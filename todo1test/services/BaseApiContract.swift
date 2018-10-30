//
//  BaseApiContract.swift
//  todo1test
//
//  Created by miguel alegria on 10/30/18.
//  Copyright © 2018 miguel alegria. All rights reserved.
//

import Foundation

protocol BaseApiContract: class {
    func getBaseUrl() -> String
    func getApiKey() -> String
}
