//
//  Movie.swift
//  DreamMovies
//
//  Created by Antonin Billot on 03/09/1400 AP.
//

import Foundation

struct MovieResponse:Codable{
    let results : [Movie]
}
struct Movie:Codable, Identifiable{
    
    let title: String
    let id: Int
    let overview: String
    let releaseDate: String
    let backdropPath: String?
    let posterPath: String?
}
