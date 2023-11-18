
import Foundation

class MovieViewModel {
    
    private var movieURLString = "https://www.omdbapi.com/?apikey=cc5baf54&s=star"
    
    var movieViewController = MovieViewController()
    
    var moviesArray: [MovieModel.Movie]?
    
    init(movieURLString: String = "https://www.omdbapi.com/?apikey=cc5baf54&s=star", moviesArray: [MovieModel.Movie]? = nil) {
        self.movieURLString = movieURLString
        self.moviesArray = moviesArray
    }
    
    func fetchMovieData() {
        NetworkManager.shared.getMovieData(urlString: movieURLString) { (result: Result<[MovieModel.Movie], Error>) in
            switch result {
            case .success(let data):
                self.moviesArray = data
                self.movieViewController.movieList = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

