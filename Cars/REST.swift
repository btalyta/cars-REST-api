//
//  REST.swift
//  Cars
//
//  Created by Bárbara Souza on 26/02/18.
//  Copyright © 2018 Bárbara Souza. All rights reserved.
//

import Foundation

enum CarError{
    case url
    case taskError(error: Error)
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJSON
    
}

class REST{
    
    private static let basePath = "https://carangas.herokuapp.com/cars"
    private static let configuration : URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = false
        config.httpAdditionalHeaders = ["Content-Type":"application/json"]
        config.timeoutIntervalForRequest = 30
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()
    private static let session = URLSession(configuration: configuration)
    
    class func loadCars(onComplete: @escaping ([Car]) -> Void, onError: @escaping (CarError) -> Void) {
        guard let url = URL(string: basePath) else {
            onError(.url)
            return
        }
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil{
                onError(.taskError(error: error!))
            }else{
                guard let response = response as? HTTPURLResponse else {
                    onError(.noResponse)
                    return
                }
                if (response.statusCode == 200){
                    guard let data = data else {return}
                    do{
                        let cars = try JSONDecoder().decode([Car].self, from: data)
                        onComplete(cars)
                    }catch{
                        print("\(error.localizedDescription)")
                        onError(.invalidJSON)
                    }
                }else{
                    print("Status inválido!")
                    onError(.responseStatusCode(code: response.statusCode))
                }
            }
        }
        dataTask.resume()
    }
}
