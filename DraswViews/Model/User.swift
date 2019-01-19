//
//  User.swift
//  DraswViews
//
//  Created by Badarinath Venkatnarayansetty on 1/19/19.
//  Copyright © 2019 Badarinath Venkatnarayansetty. All rights reserved.
//

import Foundation
import UIKit



/*
   JSON Data
 
 {
    "user_data": {
        "full_name": "John Sundell",
        "user_age": 31
    }
 }
 */

struct User: Codable {
    var name:String
    var age:Int
}

extension User {
    struct CodingData:Codable {
        struct Container:Codable {
            var fullName:String
            var userAge:Int
        }
        
        var userData:Container
    }
}

extension User.CodingData {
    var user:User {
        return User(name: userData.fullName, age: userData.userAge)
    }
}
