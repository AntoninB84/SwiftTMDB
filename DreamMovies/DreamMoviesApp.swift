//
//  DreamMoviesApp.swift
//  DreamMovies
//
//  Created by Antonin Billot on 03/09/1400 AP.
//

import SwiftUI

@main
struct DreamMoviesApp: App {
    var body: some Scene {
        WindowGroup {
            MoviesList(moviesViewModel: MoviesViewModel())
        }
    }
}
