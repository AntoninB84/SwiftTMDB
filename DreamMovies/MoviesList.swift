//
//  MoviesList.swift
//  DreamMovies
//
//  Created by Antonin Billot on 03/09/1400 AP.
//

import SwiftUI

struct MoviesList: View {
    @ObservedObject var moviesViewModel: MoviesViewModel
    var body: some View {
        NavigationView{
            List(moviesViewModel.movies){ movie in
                NavigationLink(
                    destination: MovieDetailView(moviesViewModel: moviesViewModel, movie: movie)
                        .navigationTitle(movie.title),
                    label: {
                        MovieListCell(moviesViewModel: moviesViewModel, movie: movie)
                    })
                    
            }
            .onAppear(perform: {
                moviesViewModel.fetchMovies()
            })
        }
    }
}

struct MovieDetailView: View{
    @ObservedObject var moviesViewModel : MoviesViewModel
    var movie : Movie
    
    var body: some View{
        ScrollView{
            VStack{
                Image(uiImage: moviesViewModel.backdropImages[movie.id] ?? UIImage())
                Text(movie.title)
                    .font(.headline)
                    .padding(5)
                Text(movie.overview)
                    .font(.body.italic())
                    .opacity(0.4)
                    .padding(50)
                Spacer()
                Text(movie.releaseDate)
            }
            .onAppear(perform: {
                if let path = movie.backdropPath{
                    moviesViewModel.fetchBarckdropImage(path: path, id: movie.id)
                }
            })
        }
    }
}

struct MovieListCell : View{
    @ObservedObject var moviesViewModel: MoviesViewModel
    var movie : Movie
    
    var body: some View{
        HStack{
            Image(uiImage: moviesViewModel.images[movie.id] ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
            VStack{
                Text(movie.title)
                    .font(.headline)
                    .padding(5)
                Text(movie.overview)
                    .frame(maxHeight:100)
                    .font(.body.italic())
                    .opacity(0.4)
                    .multilineTextAlignment(.leading)
                
            }
        }
        .onAppear(perform: {
            if let path = movie.posterPath{
                moviesViewModel.fetchImage(path: path, id: movie.id)
            }
        })
    }
}

struct MoviesList_Previews: PreviewProvider {
    static var previews: some View {
        MoviesList(moviesViewModel: MoviesViewModel())
    }
}
