//
//  Result.swift
//  todo1test
//
//  Created by miguel alegria on 10/30/18.
//  Copyright © 2018 miguel alegria. All rights reserved.
//

import Foundation
import ObjectMapper

class Result<T: Mappable>: Mappable {
    var currently: T?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        currently <- map["currently"]
    }
}
