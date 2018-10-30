//
//  WeatherPresenter.swift
//  todo1test
//
//  Created by miguel alegria on 10/30/18.
//  Copyright © 2018 miguel alegria. All rights reserved.
//

import Foundation
import RxSwift
class WeatherPresenter {
    
    private let concurrentScheduler = ConcurrentDispatchQueueScheduler(qos: .background)
    private let mainScheduler = MainScheduler.instance
    private let disposeBag = DisposeBag()
    private let api: WeatherService
    private let delegate: WeatherContract

    init(api: WeatherService, delegate: WeatherContract) {
        self.api = api
        self.delegate = delegate
    }
    
    func getWeather(lat: Double, lng: Double){
        self.delegate.showLoading()
        api.getWeater(lat: lat, lng: lng)
            .observeOn(concurrentScheduler)
            .subscribeOn(MainScheduler())
            .subscribe(onNext: { it in
                self.delegate.hideLoading()
                self.delegate.updateWeather(weather: it)
            }, onError: { err in
                self.delegate.hideLoading()
                self.delegate.onErr(msg: "An error has occurred, try again...")
            }, onCompleted: {
                self.delegate.hideLoading()
            })
            .disposed(by: self.disposeBag)
    }
    
    
}
