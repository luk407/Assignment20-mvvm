
import Foundation

class MovieModel: Decodable {
    class Movie: Decodable {
        var title: String
        var poster: String
        
        enum CodingKeys: String, CodingKey {
            case title = "Title"
            case poster = "Poster"
        }
    }
    
    let search: [Movie]
    let totalResults: String
    let response: String
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}
