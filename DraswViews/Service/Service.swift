//
//  Service.swift
//  DraswViews
//
//  Created by Badarinath Venkatnarayansetty on 1/5/19.
//  Copyright © 2019 Badarinath Venkatnarayansetty. All rights reserved.
//

import Foundation

enum NetWorkError: Error {
    case fetchFailed(Error)
}

public enum Result<Value, NetWorkError> {
    //Indicates success with value in the associated object
    case success(Value)

    //Indicates failure with error in the associated object
    case failure(NetWorkError)

    init(value: Value? ,error: NetWorkError?) {
        if let error = error {
            self = .failure(error)
        }else if let value = value {
            self = .success(value)
        }else {
            fatalError("Could not create Result")
        }
    }
}


class Service {
    
    let url = "https://gist.githubusercontent.com/badrinathvm/ea02c34245ed69e37ecd2e1d8386edcb/raw/5c0669f5ff477492d6c5bf43c95fea475310350d/movie.json"
    
    func callURL(endPoint: String, completion : @escaping (Result<Data,NetWorkError>)  -> Void ) {
        guard let url = URL.init(string: endPoint) else { return }
        let session = URLSession.init(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let resp = response as? HTTPURLResponse else { return }
            guard resp.statusCode == 200 else { return }
            let dataTaskError = error.map{ NetWorkError.fetchFailed($0) }
            let result = Result<Data,NetWorkError>(value: data, error: dataTaskError )
            completion(result)
        }
        task.resume()
    }
    
    func decodeModel<T:Decodable>(type: T.Type, completion: @escaping([T]) -> Void ) {
        callURL(endPoint: url) { (result) in
            if case Result.success(let data) = result {
                DispatchQueue.main.async {
                    let decoder = JSONDecoder()
                    do {
                        let model = try decoder.decode([T].self, from: data)
                        completion(model)
                    }catch let error {
                     print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
}
