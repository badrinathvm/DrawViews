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
    
    var movieListViewModel:MovieListViewModel?
    var dataSource:CustomDataSource<MovieViewModel>?
    fileprivate let reuseIdentifier = "movieCell"
    
    var imageFetcher = ImageFetcher()
    
    lazy var tableView: UITableView = { [unowned self] in
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MovieCell.self, forCellReuseIdentifier: self.reuseIdentifier)
        tableView.prefetchDataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(tableView)
    
        NSLayoutConstraint.activate([
                self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
                self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
                self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        self.movieListViewModel = MovieListViewModel(service: Service(), handler: {
            guard let viewModels = self.movieListViewModel?.movieViewModels else { return }
            self.dataSource = CustomDataSource.make(items: viewModels, reuseIdentifier: self.reuseIdentifier)
            self.tableView.dataSource = self.dataSource
            self.tableView.reloadData()
        })
    }
    
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected Row is \(indexPath.row)")
        
        //navigate to new View controller
        let cardVC = CardviewController()
        self.navigationController?.pushViewController(cardVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
}

extension CustomDataSource where Items == MovieViewModel {
    static func make(items: [Items], reuseIdentifier: String ) -> CustomDataSource {
        let dataSource = CustomDataSource(items: items, reuseIdentifier: reuseIdentifier) { (cell, model) in
           //configure cell here
            let _cell = cell as! MovieCell
            _cell.movieName.text = model.movie.name
            _cell.shortDescription.text = model.movie.shortDescription
            
            //for image
             ImageFetcher().loadImage(thumbnailUrl: model.movie.thumbnailUrl, completion: { (image) in
                _cell.mainImage.image = image
            })
        }
        
        return dataSource
    }
}

extension MainViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            guard let model = self.movieListViewModel?.movieViewModels[indexPath.row] else { return }
            self.imageFetcher.loadImage(thumbnailUrl: model.movie.thumbnailUrl, completion: { (image) in
                print("Image Downloaded at \(indexPath.row)")
            })
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
             guard let model = self.movieListViewModel?.movieViewModels[indexPath.row] else { return }
           self.imageFetcher.cancelDownloadingImage(url: model.movie.thumbnailUrl)
             print("Cancelling PeFetching \(indexPath)")
        }
    }
    
}


