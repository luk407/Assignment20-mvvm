
import UIKit

//MARK: View
final class MovieView: UIView {
    
    //MARK: - Properties
    private let mainStackView = UIStackView()
    let movieTableView = UITableView()
    //var movieList = [MovieModel.Movie]()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        setupConstraints()
        setupUI()
        registerMovieTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Add SubViews, Constraints, UI
    private func addSubViews() {
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(movieTableView)
    }
    
    private func setupConstraints() {
        setupMainStackViewConstraints()
        setupMovieTableViewConstraints()
    }
    
    private func setupUI() {
        setupMainStackViewUI()
        setupMovieTableViewUI()
    }
    
    //MARK: - Setup UI
    private func setupMainStackViewUI() {
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.spacing = 0
        mainStackView.alignment = .center
        mainStackView.distribution = .fillProportionally
    }
    
    private func setupMovieTableViewUI() {
        movieTableView.translatesAutoresizingMaskIntoConstraints = false
    }

    //MARK: - Constraints
    private func setupMainStackViewConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            mainStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupMovieTableViewConstraints() {
        NSLayoutConstraint.activate([
            movieTableView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor),
            movieTableView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor)
        ])
    }
    
    private func registerMovieTableViewCell() {
        movieTableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "movieCell")
    }
}

//MARK: Controller
final class MovieViewController: UIViewController {
    
    //MARK: - Properties
    var movieView: MovieView
    var viewModel: MovieViewModel
    var movieList: [MovieModel.Movie] //აი ამ ერეის განახლება ვერ გავაკეთებინე. არადა updateView მეთოდი მაგას უნდა აკეთებდეს ქვემოთ.
    
    //MARK: - Init
    init() {
        self.movieView = MovieView()
        self.viewModel = MovieViewModel()
        self.movieList = viewModel.moviesArray ?? []
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = movieView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieView.movieTableView.delegate = self
        movieView.movieTableView.dataSource = self
        updateView()
    }

    private func updateView() {
        viewModel.fetchMovieData()
        //self.movieView.movieList = viewModel.moviesArray!
        
        DispatchQueue.main.async {
            self.movieView.movieTableView.reloadData()
        }
    }
}
    
//MARK: - Controller Extension
extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        let movie = movieList[indexPath.row]
        cell = movieView.movieTableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        
        if let movieCell = cell as? MovieTableViewCell {
            movieCell.configureCell(with: movie)
        }
        return cell
    }

}
