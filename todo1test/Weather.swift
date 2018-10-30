//
//  Weather.swift
//  todo1test
//
//  Created by miguel alegria on 10/30/18.
//  Copyright © 2018 miguel alegria. All rights reserved.
//

import Foundation
import ObjectMapper

class Weather:  Mappable{
    
    var temperature: Double?
    var summary: String?
    var icon: String?
    var humidity: Double?
    var precipProbability: Double?
    
    
    private struct SerializationKeys {
        static let temperature = "temperature"
        static let summary = "summary"
        static let icon = "icon"
        static let humidity = "humidity"
        static let precipProbability = "precipProbability"
    }
    
    public func mapping(map: Map) {
        temperature <- map[SerializationKeys.temperature]
        summary <- map[SerializationKeys.summary]
        icon <- map[SerializationKeys.icon]
        humidity <- map[SerializationKeys.humidity]
        precipProbability <- map[SerializationKeys.precipProbability]
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
}
