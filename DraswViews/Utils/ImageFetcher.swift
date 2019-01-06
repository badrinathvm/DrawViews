//
//  ImageFetcher.swift
//  DraswViews
//
//  Created by Badarinath Venkatnarayansetty on 1/6/19.
//  Copyright © 2019 Badarinath Venkatnarayansetty. All rights reserved.
//

import Foundation
import UIKit


var imageCache = NSCache<AnyObject, AnyObject>()


class ImageFetcher {
    
    //Need an array of URLSessions
    
    var tasks = [URLSessionTask]()
    
    func loadImage(thumbnailUrl: String, completion: @escaping (UIImage) -> ())  {
       
        //Check image Cache before making a network call
//        if let image = imageCache.object(forKey: thumbnailUrl as AnyObject)  as? UIImage {
//            completion(image)
//            return
//        }
        
        
        guard let url = URL.init(string: thumbnailUrl) else { return }
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data {
                    guard let image = UIImage(data: data) else { return }
                    imageCache.setObject(image, forKey: thumbnailUrl as AnyObject)
                    completion(image)
                }
            }
        }
        
        task.resume()
        tasks.append(task)
    }
    
    
    func cancelDownloadingImage(url: String) {
        guard let u = URL.init(string: url) else { return }
        guard let taskIndex = tasks.index( where : { $0.originalRequest?.url == u }) else  { return }
        let task = tasks[taskIndex]
        task.cancel()
        tasks.remove(at: taskIndex)
    }
    
}
