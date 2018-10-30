//
//  Log.swift
//  todo1test
//
//  Created by miguel alegria on 10/30/18.
//  Copyright © 2018 miguel alegria. All rights reserved.
//

import Foundation

public class Log{
    
    public static func Log(msg:String){
        print("\(msg)")
    }
    
    public static func Log(tag: String, msg: String){
        let out = "\(tag)  \(msg)"
        print("\(out)")
    }
    
    
}
