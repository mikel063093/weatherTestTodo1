//
//  Api.swift
//  todo1test
//
//  Created by miguel alegria on 10/30/18.
//  Copyright © 2018 miguel alegria. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import AlamofireObjectMapper
import ObjectMapper

class Api {
    
    private var headers: HTTPHeaders = [
        "Authorization": "",
        "Content-Type": "application/json",
        "X-Auth-Token": ""
    ]
    
    init(useCellular : Bool = true) {
        Alamofire.SessionManager.default.session.configuration.timeoutIntervalForRequest = 30
        Alamofire.SessionManager.default.session.configuration.timeoutIntervalForResource = 30
        Alamofire.SessionManager.default.session.configuration.allowsCellularAccess = useCellular
    }
    
    func post<T: Mappable>(url: String, params: [String: Any], typeReference: [T])-> Observable<T>{
        self.headers.updateValue("" , forKey: "X-Auth-Token")
        
        return Observable.create({observer -> Disposable in
            
            Alamofire.request(url, method: .post, parameters: params,  encoding: JSONEncoding.default,
                              headers : self.headers )
                .validate()
                .responseJSON{ response in
                    Log.Log(msg: "Endpoint --> " + url)
                    Log.Log(msg: "🤔 \(String(describing: String(data: response.data!, encoding: .utf8)))")
                }
                .responseObject { (response: DataResponse<T>) in
                    
                    if(response.error != nil){
                        Log.Log(msg:"😡 Houston we have a problem \(response.error!) ")
                        observer.onError(response.result.error!)
                        observer.onCompleted()
                    }else{
                        Log.Log(msg:"😇 Let's go super")
                        observer.onNext(response.result.value!)
                        observer.onCompleted()
                    }
                    
            }
            return Disposables.create()
        })
    }
    
    func get<T: Mappable>(url: String, typeReference: [T])-> Observable<T>{
        return Observable.create({observer -> Disposable in
            Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers : self.headers )
                .validate()
                .responseJSON{ response in
                    Log.Log(msg: "Endpoint --> " + url)
                    Log.Log(msg: "🤔 \(String(describing: String(data: response.data!, encoding: .utf8)))")
                }
                .responseObject { (response: DataResponse<T>) in
                    if(response.error != nil){
                        Log.Log(msg:"😡 Houston we have \(response.error!) ")
                        observer.onError(response.result.error!)
                        observer.onCompleted()
                    }else{
                        Log.Log(msg:"😇 Let's go super")
                        observer.onNext(response.result.value!)
                        observer.onCompleted()
                    }
            }
            return Disposables.create()
        })
    }
    
    
}
