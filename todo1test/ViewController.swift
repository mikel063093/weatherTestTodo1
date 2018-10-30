//
//  ViewController.swift
//  todo1test
//
//  Created by miguel alegria on 10/30/18.
//  Copyright © 2018 miguel alegria. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var lbHumidity: UILabel!
    @IBOutlet weak var lblWeather: UILabel!
    @IBOutlet weak var lblRain: UILabel!
    @IBOutlet weak var lblSummary: UILabel!
    @IBOutlet weak var imgBackground: UIImageView!
    let locationManager = CLLocationManager()
    private var presenter: WeatherPresenter? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initPresenter()
        self.locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    private func initPresenter(){
        let service = Api()
        let weatherService = WeatherService(service: service)
        presenter = WeatherPresenter(api: weatherService, delegate: self)
    }

    @IBAction func refresh(_ sender: Any) {
        
    }
    
}

extension ViewController: WeatherContract{
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
    func updateWeather(weather: Weather) {
        
    }
    
    func onErr(msg: String) {
        
    }
    
    
}

extension ViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else {return}
         presenter?.getWeather(lat: locValue.latitude, lng: locValue.longitude)
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
            locationManager.startUpdatingLocation()
        } else {
            onErr(msg: "Denied access: \(locationStatus)")
        }
    }
    
}

