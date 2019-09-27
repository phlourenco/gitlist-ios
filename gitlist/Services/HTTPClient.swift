//
//  HTTPClient.swift
//  gitlist
//
//  Created by Paulo Lourenço on 26/09/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import Foundation
import RxSwift

class HTTPClient {
    
    enum Errors: Error {
        case unknownStatusCode
        case parseError
        case errorStatusCode(Int)
    }
    
    enum MethodType: String {
        case get = "GET"
        case post = "POST"
    }
    
    func request<T: Decodable>(url: String, method: MethodType, parameters: [String: Any]? = nil, headers: [String: String]? = nil, parseAs object: T.Type, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> Observable<T> {
        
        var completeURL = URLComponents(string: url)!
        if let params = parameters {
            completeURL.queryItems = []
            for (name, value) in params {
                completeURL.queryItems?.append(URLQueryItem.init(name: name, value: "\(value)"))
            }
        }
        
        var urlRequest = URLRequest(url: completeURL.url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 5)
        
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpMethod = method.rawValue
        
        let ob: Observable<T> = Observable.create { observer in
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    observer.onError(error)
                    return
                }

                guard let response = response as? HTTPURLResponse else {
                    observer.onError(Errors.unknownStatusCode)
                    return
                }

                switch response.statusCode {
                case 200..<299:
                    if let parsedObj = data?.parse(asObject: T.self, usingKeyDecodingStrategy: keyDecodingStrategy) {
                        observer.onNext(parsedObj)
                    } else {
                        observer.onError(Errors.parseError)
                    }
                default:
                    observer.onError(Errors.errorStatusCode(response.statusCode))
                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
        .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
        .observeOn(MainScheduler.instance)
        
        return ob

        
//        return Promise<T> { seal in
//            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
//                if let error = error {
//                    seal.reject(error)
//                    return
//                }
//
//                guard let response = response as? HTTPURLResponse else {
//                    seal.reject(Errors.unknownStatusCode)
//                    return
//                }
//
//                switch response.statusCode {
//                case 200..<299:
//                    if let parsedObj = data?.parse(asObject: T.self) {
//                        seal.fulfill(parsedObj)
//                    } else {
//                        seal.reject(Errors.parseError)
//                    }
//                default:
//                    seal.reject(Errors.errorStatusCode(response.statusCode))
//                }
//            }
//            task.resume()
//        }
    }
    
}
