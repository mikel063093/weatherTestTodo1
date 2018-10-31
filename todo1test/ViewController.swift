//
//  ViewController.swift
//  todo1test
//
//  Created by miguel alegria on 10/30/18.
//  Copyright © 2018 miguel alegria. All rights reserved.
//

import UIKit
import SwiftEntryKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherPercentageLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var imgBackground: UIImageView!
    
    let locationManager = CLLocationManager()
    private var presenter: WeatherPresenter? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initPresenter()
        initLocation()
        initUi()
    }
    
    private func initUi(){
        let color1 = ColorUtil.hexStringToUIColor(hex: "#2193b0")
        let color2 = ColorUtil.hexStringToUIColor(hex: "#6dd5ed")
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        let image = UIImage.gradientImageWithBounds(bounds: self.imgBackground.bounds, colors: [color1.cgColor, color2.cgColor])
        self.imgBackground.image = image
    }
    
    private func initLocation(){
        self.locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestLocation()
        }
    }
    
    private func initPresenter(){
        let service = Api()
        let weatherService = WeatherService(service: service)
        presenter = WeatherPresenter(api: weatherService, delegate: self)
    }
    
    @IBAction func refresh(_ sender: Any) {
        initLocation()
    }
    
}

extension ViewController: WeatherContract{
    
    func showLoading() {
        DispatchQueue.main.async(execute: {
            SwiftLoader.show(title: "Loading...", animated: true)
        })
    }
    
    func hideLoading() {
        DispatchQueue.main.async(execute: {
            SwiftLoader.hide()
        })
    }
    
    func updateWeather(weather currentWeather: Weather) {
        DispatchQueue.main.async(execute: {
            guard let weatherSummary = currentWeather.summary, let weatherTemperature = currentWeather.temperature, let weatherHumidity = currentWeather.humidity, let weatherIcon = currentWeather.icon, let weatherProbability = currentWeather.precipProbability else{return}
            self.temperatureLabel.text = String(format:"%.0f", self.fahrenheitToCelsius(tempInF: weatherTemperature)) + "°C"
            self.summaryLabel.text = weatherSummary
            self.humidityLabel.text = String(format:"%.1f", weatherHumidity) + "%"
            self.weatherLabel.text = weatherIcon.uppercased()
            self.weatherPercentageLabel.text = String(format:"%.1f", weatherProbability) + "%"
        })
        
    }
    
    func fahrenheitToCelsius(tempInF:Double) ->Double {
        let celsius: Double = (tempInF - 32) * (5/9)
        return celsius
    }
    
    func onErr(msg: String) {
        DispatchQueue.main.async(execute: {
            var attributes = EKAttributes()
            attributes.position = .bottom
            attributes.roundCorners = .all(radius: 3)
            let style = EKProperty.LabelStyle(font: MainFont.light.with(size: 13), color: .white, alignment: .center)
            let labelContent = EKProperty.LabelContent(text: msg, style: style)
            
            let contentView = EKNoteMessageView(with: labelContent)
            
            SwiftEntryKit.display(entry: contentView, using: attributes)
        })
        
    }
    
    
}

extension ViewController: CLLocationManagerDelegate{
    
    fileprivate func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?)-> Void ) {
        if let lastLocation = self.locationManager.location {
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(lastLocation, completionHandler: { (placemarks, error) in
                if error == nil {
                    let firstLocation = placemarks?[0]
                    completionHandler(firstLocation)
                }else {
                    completionHandler(nil)
                }
            })
        }
        else {
            completionHandler(nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else {return}
        presenter?.getWeather(lat: locValue.latitude, lng: locValue.longitude)
        self.lookUpCurrentLocation { (currentUserPlace) in
            guard let city = currentUserPlace?.locality else {return}
            self.cityLabel.text = city
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        onErr(msg: error.localizedDescription)
    }
    
    private func locationManager(manager: CLLocationManager!,
                                 didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        var shouldIAllow = false
        var locationStatus : NSString = "Not Started"
        
        switch status {
        case CLAuthorizationStatus.restricted:
            locationStatus = "Restricted Access to location"
        case CLAuthorizationStatus.denied:
            locationStatus = "User denied access to location"
        case CLAuthorizationStatus.notDetermined:
            locationStatus = "Status not determined"
        default:
            locationStatus = "Allowed to location Access"
            shouldIAllow = true
        }
        
        if (shouldIAllow == true) {
            Log.Log(msg:"Location to Allowed")
            locationManager.requestLocation()
        } else {
            onErr(msg: "Denied access: \(locationStatus)")
        }
    }
    
}

extension UIImage {
    static func gradientImageWithBounds(bounds: CGRect, colors: [CGColor]) -> UIImage {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
