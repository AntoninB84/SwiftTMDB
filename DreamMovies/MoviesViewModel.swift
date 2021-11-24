//
//  MoviesViewModel.swift
//  DreamMovies
//
//  Created by Antonin Billot on 03/09/1400 AP.
//

import SwiftUI
import Combine


class MoviesViewModel:ObservableObject{
    
    @Published var movies = [Movie]()
    @Published var images = [Int : UIImage]()
    @Published var backdropImages = [Int : UIImage]()
    
    private var movieFetcher = MovieFetcher()
    private var moviesCancellable : AnyCancellable?
    private var imageCancellables = Set<AnyCancellable>()
    
    func fetchMovies(){
        moviesCancellable = movieFetcher
            .nowPlayingPublisher
            .assign(to: \.movies, on: self)
    }
    func fetchImage(path: String, id: Int){
         movieFetcher
            .imagePublisher(path: path)
            .sink{ image in
                self.images[id] = image
            }
            .store(in: &imageCancellables)
    }
    func fetchBarckdropImage(path: String, id: Int){
         movieFetcher
            .imagePublisher(path: path)
            .sink{ image in
                self.backdropImages[id] = image
            }
            .store(in: &imageCancellables)
    }
}
