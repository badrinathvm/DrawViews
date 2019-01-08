//
//  CardLayout.swift
//  DraswViews
//
//  Created by Badarinath Venkatnarayansetty on 1/7/19.
//  Copyright © 2019 Badarinath Venkatnarayansetty. All rights reserved.
//

import Foundation
import UIKit

class CardLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        
        guard let cv = collectionView else  { return }
        
        self.sectionInset = UIEdgeInsets(top: self.minimumLineSpacing, left: 0.0, bottom: 0.0, right: 0.0)
        self.itemSize = CGSize(width: 100, height: 100.0)
        self.sectionInsetReference = .fromSafeArea
    }
}
