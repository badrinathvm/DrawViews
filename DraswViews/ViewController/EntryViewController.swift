//
//  EntryViewController.swift
//  DraswViews
//
//  Created by Badarinath Venkatnarayansetty on 1/7/19.
//  Copyright © 2019 Badarinath Venkatnarayansetty. All rights reserved.
//

import Foundation
import UIKit

class EntryViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor.white
        self.delegate = self
        
        let moviesVC = MainViewController()
        moviesVC.title = "Movies"
        moviesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        
        let cardsVC = CardviewController()
        cardsVC.title = "Cards"
        cardsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 1)
        
        self.viewControllers = [ moviesVC, cardsVC ]
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected View Controller us \(String(describing: viewController.tabBarItem.tag))")
    }
}
