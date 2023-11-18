
import UIKit

final class MovieTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    private let mainStackView = UIStackView()
    
    private var moviePosterImageView = UIImageView()
    
    private let movieNameTextView = UITextView()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubViews()
        setupConstraints()
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Prepare for Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        moviePosterImageView.image = nil
        movieNameTextView.text = nil
    }
    
    //MARK: - Methods
    private func addSubViews() {
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(moviePosterImageView)
        mainStackView.addArrangedSubview(movieNameTextView)
    }
    
    private func setupConstraints() {
        setupMainStackViewConstraints()
        setupMoviePosterImageViewConstraints()
        setupMovieNameTextViewConstraints()
    }
    
    private func setupUI() {
        setupMainStackViewUI()
        setupMoviePosterImageViewUI()
        setupMovieNameTextViewUI()
    }
    
    func configureCell(with movie: MovieModel.Movie) {
        setImage(from: movie.poster)
        movieNameTextView.text = movie.title
    }
    
    private func setImage(from url: String) {
        NetworkManager.shared.downloadMovieImage(from: url) { [weak self] image in
            DispatchQueue.main.async {
                self?.moviePosterImageView.image = image
            }
        }
    }
    
    //MARK: - UI
    private func setupMainStackViewUI() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.isLayoutMarginsRelativeArrangement = true
        mainStackView.axis = .horizontal
        mainStackView.spacing = 5
        mainStackView.alignment = .center
    }
    
    private func setupMoviePosterImageViewUI() {
        moviePosterImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupMovieNameTextViewUI() {
        movieNameTextView.translatesAutoresizingMaskIntoConstraints = false
        movieNameTextView.font = UIFont.boldSystemFont(ofSize: 20)
        movieNameTextView.textAlignment = .left
        movieNameTextView.textColor = .black
        movieNameTextView.textContainer.lineBreakMode = NSLineBreakMode.byCharWrapping
    }
    
    //MARK: - Constraints
    private func setupMainStackViewConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mainStackView.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    private func setupMoviePosterImageViewConstraints() {
        NSLayoutConstraint.activate([
            moviePosterImageView.heightAnchor.constraint(equalToConstant: 120),
            moviePosterImageView.widthAnchor.constraint(equalTo: moviePosterImageView.heightAnchor)
        ])
    }
    
    private func setupMovieNameTextViewConstraints() {
        NSLayoutConstraint.activate([
            movieNameTextView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
}

