//
//  WeatherContract.swift
//  todo1test
//
//  Created by miguel alegria on 10/30/18.
//  Copyright © 2018 miguel alegria. All rights reserved.
//

import Foundation
protocol WeatherContract: class {
    func showLoading()
    func hideLoading()
    func updateWeather(weather: Weather)
    func onErr(msg: String)
}
