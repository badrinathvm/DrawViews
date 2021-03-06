//
//  CardCell.swift
//  DraswViews
//
//  Created by Badarinath Venkatnarayansetty on 1/7/19.
//  Copyright © 2019 Badarinath Venkatnarayansetty. All rights reserved.
//

import Foundation
import UIKit

class CardCell: UICollectionViewCell {
    
    private var currentSize = CGSize.zero
    var cardContentView:UIView = {
        let cardView = UIView()
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.backgroundColor = UIColor.blue
        //cardView.addGradientWithColor(color: UIColor.red)
        cardView.layer.cornerRadius = 10.0
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowRadius = 5.0
        cardView.layer.shadowOpacity = 0.9
        return cardView
    }()
    
    var pieChart:PieChartView = {
       let chart = PieChartView()
        chart.backgroundColor = UIColor.white
       chart.translatesAutoresizingMaskIntoConstraints = false
        return chart
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    var heightConstraint: NSLayoutConstraint?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    func setup() {
        heightConstraint = self.cardContentView.heightAnchor.constraint(equalToConstant: 200)
        self.contentView.addSubview(cardContentView)
        
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [UIColor.white.cgColor,UIColor.red.withAlphaComponent(1).cgColor ]
//        cardContentView.layer.addSublayer(gradientLayer)
        
        
        NSLayoutConstraint.activate([
            self.cardContentView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.cardContentView.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: 30),
            self.cardContentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            //self.cardContentView.heightAnchor.constraint(equalToConstant: 200)
            heightConstraint!
        ])
        
        self.contentView.addSubview(pieChart)
        pieChart.segments = [ Segment(color: UIColor.red , value: 57) , Segment(color: UIColor.blue, value: 30) , Segment(color: UIColor.green, value: 25), Segment(color: UIColor.yellow, value: 40) ]
        
        NSLayoutConstraint.activate([
            self.pieChart.topAnchor.constraint(equalTo: self.cardContentView.bottomAnchor, constant: 50),
            self.pieChart.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            self.pieChart.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            self.pieChart.heightAnchor.constraint(equalToConstant: 300)
        ])
    }

}


extension UIView {
    func addGradientWithColor(color: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [UIColor.clear.cgColor, color.cgColor]
        
        self.layer.insertSublayer(gradient, at: 0)
    }
}
