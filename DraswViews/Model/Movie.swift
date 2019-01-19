//
//  Movie.swift
//  DraswViews
//
//  Created by Badarinath Venkatnarayansetty on 1/5/19.
//  Copyright © 2019 Badarinath Venkatnarayansetty. All rights reserved.
//

import Foundation
import UIKit

struct Movie:Codable {
    var id:Int
    var name:String
    var shortDescription:String
    var thumbnailUrl: String
    var category:Int
    var venue:Int
}

enum MovieKeys : String, CodingKey {
    case id = "uid"
    case name = "name"
    case shortDescription = "shortDesc"
    case thumbnailUrl = "thumbnailUrl"
    case category = "category"
    case venue = "venue"
}

extension Movie {
    
    //Note : Using Coding Keys
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        shortDescription = try container.decode(String.self, forKey: .shortDescription)
        thumbnailUrl = try container.decode(String.self, forKey: .thumbnailUrl)
        category = try container.decode(Int.self, forKey: .category)
        venue = try container.decode(Int.self, forKey: .venue)
    }
   
    //Note  : without using Coding Keys
    struct CodingData: Codable {
        struct Container:Codable {
            var uid:Int
            var name:String
            var shortDesc:String
            var thumbnailUrl: String
            var category:Int
            var venue:Int
        }
    }
}

