//
//  PhotoViewModel.swift
//  DraswViews
//
//  Created by Badarinath Venkatnarayansetty on 1/5/19.
//  Copyright © 2019 Badarinath Venkatnarayansetty. All rights reserved.
//

import Foundation
import UIKit


class MovieListViewModel {
    typealias Handler = () -> Void
    private(set) var movieViewModels  = [MovieViewModel]()
    var service:Service
    var handler: Handler
    
    init(service: Service, handler: @escaping Handler) {
        self.service = service
        self.handler = handler
        //fetchMovieData()
        //fetchUserData()
         service.callMovieService()
    }
    
    func fetchMovieData() {
        service.decodeModel(type: Movie.self, completion: { (movies) in
            self.movieViewModels = movies.map(MovieViewModel.init)
            self.handler()
        })
    }
    
    func fetchUserData() {
        service.callUserService()
    }
}

class MovieViewModel {
    let movie:Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
}
