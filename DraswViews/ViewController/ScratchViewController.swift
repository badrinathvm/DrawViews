//
//  ScratchViewController.swift
//  DraswViews
//
//  Created by Badarinath Venkatnarayansetty on 1/7/19.
//  Copyright © 2019 Badarinath Venkatnarayansetty. All rights reserved.
//

import Foundation
import UIKit

class ScratchViewController: UIViewController {
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        
        let scratchView = ScratchView()
        scratchView.translatesAutoresizingMaskIntoConstraints = false
        scratchView.backgroundColor = UIColor.white
        self.view.addSubview(scratchView)
        
        NSLayoutConstraint.activate([
            scratchView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scratchView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            scratchView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            scratchView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
}
