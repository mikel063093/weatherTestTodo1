//
//  WeatherService.swift
//  todo1test
//
//  Created by miguel alegria on 10/30/18.
//  Copyright © 2018 miguel alegria. All rights reserved.
//

import Foundation
import RxSwift

class WeatherService: BaseApiContract {
    
    internal func getBaseUrl() -> String {
        return "https://api.darksky.net/forecast/"
    }
    
    internal func getApiKey() -> String {
        return "bf3a7972fe987f3137cf515ae1d115ee"
    }
    
    let service : Api
    
    init(service : Api){
        self.service = service
    }
    
    func getWeater(lat: Double, lng: Double) -> Observable<Weather> {
        let url = "\(getBaseUrl())/\(getApiKey())/\(lat)/,\(lng)"
        return service.get(url: url, typeReference: [Weather]()).asObservable()
    }
    
}
