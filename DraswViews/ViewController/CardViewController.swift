//
//  CardViewController.swift
//  DraswViews
//
//  Created by Badarinath Venkatnarayansetty on 1/7/19.
//  Copyright © 2019 Badarinath Venkatnarayansetty. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CardviewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
   
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cv.register(CardCell.self, forCellWithReuseIdentifier: "cardCell")
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let pageControl: UIPageControl = {
       let pc = UIPageControl()
       pc.translatesAutoresizingMaskIntoConstraints = false
        pc.pageIndicatorTintColor = UIColor.gray
        pc.currentPageIndicatorTintColor = UIColor.green
        return pc
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(collectionView)
        
        self.collectionView.backgroundColor = UIColor.white
        //set constraints
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        self.view.addSubview(pageControl)
        self.pageControl.numberOfPages = 5
        NSLayoutConstraint.activate([
            self.pageControl.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -30.0),
            self.pageControl.heightAnchor.constraint(equalToConstant: 60),
            self.pageControl.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.pageControl.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! CardCell
        //cell.backgroundColor = UIColor.cyan
        //cell.cardContentView.gradientColors = [UIColor.blue, UIColor.cyan]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.safeAreaFrame.width - 70, height: self.view.safeAreaFrame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //here increase the height of the cell.
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! CardCell
//        cell.contentView.backgroundColor = UIColor.red
        
//        UIView.animate(withDuration: 0.5, delay: 1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
////            cell.heightConstraint?.constant = 300.0
////
////            self.loadViewIfNeeded()
//        }, completion: nil)
        
        
        if let cell = cell as? CardCell {
            cell.cardContentView.backgroundColor = UIColor.red
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? CardCell else  { return }
        cell.cardContentView.backgroundColor = UIColor.blue
    }

}

extension CardviewController {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        //Get the page number
        let pageNumber =  Int( targetContentOffset.pointee.x / view.frame.width - 70 )
        pageControl.currentPage = 70 + pageNumber
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}


extension UIView {
    var safeAreaFrame: CGRect {
        if #available(iOS 11, *) {
            return safeAreaLayoutGuide.layoutFrame
        }
        return bounds
    }
}
