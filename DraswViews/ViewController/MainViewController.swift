//
//  MainViewController.swift
//  DraswViews
//
//  Created by Badarinath Venkatnarayansetty on 1/5/19.
//  Copyright © 2019 Badarinath Venkatnarayansetty. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        Service().decodeModel(type: Movie.self) { (result) in
            print(result)
        }
    }
}
