//
//  WeatherService.swift
//  todo1test
//
//  Created by miguel alegria on 10/30/18.
//  Copyright © 2018 miguel alegria. All rights reserved.
//

import Foundation
import RxSwift

class WeatherService{
    
    let service : Api
    
    init(service : Api){
        self.service = service
    }
    
    func getWeater(lat: Double, lng: Double) -> Observable<Weather> {
        return service.get(url: "", typeReference:  [Weather]()).asObservable()
    }
    
}
