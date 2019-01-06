//
//  CustomDataSource.swift
//  DraswViews
//
//  Created by Badarinath Venkatnarayansetty on 1/5/19.
//  Copyright © 2019 Badarinath Venkatnarayansetty. All rights reserved.
//

import Foundation
import UIKit

class CustomDataSource<Items> : NSObject, UITableViewDataSource {
    typealias CellConfig = (UITableViewCell, Items) -> ()
    var items:[Items]
    var cellConfig: CellConfig
    var reuseIdentifer:String
    
    init(items: [Items] , reuseIdentifier: String , cellConfig: @escaping CellConfig) {
        self.items = items
        self.reuseIdentifer = reuseIdentifier
        self.cellConfig = cellConfig
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = items[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifer, for: indexPath)
        
        cellConfig(cell, model)
        
        return cell
    }
    
}
