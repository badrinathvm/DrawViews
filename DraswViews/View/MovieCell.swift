//
//  MovieCell.swift
//  DraswViews
//
//  Created by Badarinath Venkatnarayansetty on 1/5/19.
//  Copyright © 2019 Badarinath Venkatnarayansetty. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MovieCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let mainImage:UIImageView = {
        var mainImage = UIImageView()
        mainImage.translatesAutoresizingMaskIntoConstraints = false
        mainImage.layer.borderWidth = 2.0
        mainImage.layer.borderColor = UIColor.black.cgColor
        return mainImage
    }()
    
    let movieName:UILabel = {
       var label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       label.font = UIFont.systemFont(ofSize: 14)
       label.layer.borderWidth = 2.0
        label.layer.borderColor = UIColor.black.cgColor
       return label
    }()
    
    let shortDescription: UILabel = {
       var label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.borderWidth = 2.0
        label.layer.borderColor = UIColor.black.cgColor
       label.font = UIFont.systemFont(ofSize: 12)
       return label
    }()
    
    func setup() {
        [mainImage,movieName,shortDescription].forEach {
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            self.mainImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.mainImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            self.mainImage.widthAnchor.constraint(equalToConstant: 100),
            self.mainImage.heightAnchor.constraint(equalTo: self.mainImage.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
                self.movieName.leadingAnchor.constraint(equalTo: self.mainImage.trailingAnchor, constant: 10),
                self.movieName.topAnchor.constraint(equalTo: self.mainImage.topAnchor),
                self.movieName.heightAnchor.constraint(equalToConstant: 40),
                self.movieName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
                self.shortDescription.topAnchor.constraint(equalTo: self.movieName.bottomAnchor, constant: 5),
                self.shortDescription.leadingAnchor.constraint(equalTo: self.movieName.leadingAnchor),
                self.shortDescription.trailingAnchor.constraint(equalTo: self.movieName.trailingAnchor),
                self.shortDescription.heightAnchor.constraint(equalTo: self.movieName.heightAnchor)
        ])
        
    }
}

