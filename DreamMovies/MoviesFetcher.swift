//
//  MoviesFetcher.swift
//  DreamMovies
//
//  Created by Antonin Billot on 03/09/1400 AP.
//

import Foundation
import Combine
import UIKit.UIImage

struct MovieFetcher{
    
    var nowPlayingPublisher: AnyPublisher<[Movie],Never>{
        
        let moviesURLString = "https://api.themoviedb.org/3/movie/now_playing?api_key=e46dd3f9da22440b62034867de12ca2b&language=fr"

        let movieURL = URL(string: moviesURLString)!
        let moviesPublisher = URLSession.shared.dataTaskPublisher(for: movieURL)

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return moviesPublisher
            .map(\.data)
            .decode(type: MovieResponse.self, decoder: decoder)
            .map(\.results)
            .replaceError(with: [Movie]())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func imagePublisher(path:String)-> AnyPublisher<UIImage, Never>{
        let baseURLString = "https://image.tmdb.org/t/p/w500"
        let urlString = baseURLString + path
        let imageURL = URL(string: urlString)!
        let imagePublisher = URLSession.shared.dataTaskPublisher(for: imageURL)
        return imagePublisher
            .map(\.data)
            .map({ data in
                return UIImage(data:data) ?? UIImage()
            })
            .replaceError(with: UIImage())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
