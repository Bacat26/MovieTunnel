//
//  MovieDetailViewController.swift
//  MoviesTunnel
//
//  Created by bilal acat on 11.05.2022.
//

import UIKit
import Kingfisher

protocol MovieDetailDelegate: NSObject {
  func checkFavoriteListChanged()
}

class MovieDetailViewController: UIViewController {
  @IBOutlet weak var movieNameLabel: UILabel!
  @IBOutlet weak var genresLabel: UILabel!
  @IBOutlet weak var reviewLabel: UILabel!
  @IBOutlet weak var durationLabel: UILabel!
  @IBOutlet weak var releaseDateLabel: UILabel!
  @IBOutlet weak var durationContainerView: UIView!
  @IBOutlet weak var reviewContainerView: UIView!
  @IBOutlet weak var relaeseDateContainerView: UIView!
  @IBOutlet weak var favoriteButtonImageView: UIImageView!
  @IBOutlet weak var favoriteButtonTitle: UILabel!
  @IBOutlet weak var backdropImageView: UIImageView!
  @IBOutlet weak var posterImageView: UIImageView!
  @IBOutlet weak var tableView: UITableView!
  
  var viewModel: MovieDetailViewModel!
  weak var delegate: MovieDetailDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupLayout()
    viewModel.getMovieDetail()
    viewModel.updateByDetailResponse = self.updateByDetailResponse()
    setupTableView()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    delegate?.checkFavoriteListChanged()
  }
  
  func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UINib(nibName: "MovieDescriptionTVC", bundle: nil), forCellReuseIdentifier: "MovieDescriptionTVC")
    tableView.register(UINib(nibName: "HorizantalListTVC", bundle: nil), forCellReuseIdentifier: "HorizantalListTVC")
  }
  
  func setupLayout() {
    movieNameLabel.text = viewModel.movieName
    reviewLabel.text = viewModel.review
    releaseDateLabel.text = viewModel.releaseDate
    posterImageView.kf.setImage(with: viewModel.posterUrl, placeholder: UIImage(named: "placeholder")!)
    backdropImageView.kf.setImage(with: viewModel.backdropUrl, placeholder: UIImage(named: "placeholder")!)
    setupFavoriteButton()
  }
  
  func setupFavoriteButton() {
    self.favoriteButtonImageView.tintImageColor(color: (self.viewModel.isFavorite ?? false) ? UIColor.systemOrange : UIColor("#BFBFBF"))
  }
  
  func updateByDetailResponse() -> (() -> ())? {
    return { [weak self] in
      guard let self = self else { return }
      self.setupLayout()
      self.genresLabel.text = self.viewModel.genres
      self.tableView.reloadData()
    }
  }
  
  @IBAction func favoriteButtonAction(_ sender: Any) {
    if (viewModel.isFavorite ?? false) {
      FavoriteStorageManager.shared.removeFavoriteMovie(movieID: viewModel.movie.id)
    } else {
      FavoriteStorageManager.shared.addItemFavoriteList(movie: viewModel.movie)
    }
    viewModel.isFavorite?.toggle()
    setupFavoriteButton()
  }
  
  @IBAction func shareButtonAction(_ sender: Any) {
    let shareVC = UIActivityViewController(activityItems: [self.viewModel.movieName, self.viewModel.posterUrl ?? ""], applicationActivities: nil)
    self.present(shareVC, animated: true, completion: nil)
  }
  
  @IBAction func watchButtonAction(_ sender: Any) {
    guard let youtubeId = self.viewModel.getTrailerVideoId() else { return }
    var youtubeUrl = URL(string:"youtube://\(youtubeId)")!
    if UIApplication.shared.canOpenURL(youtubeUrl){
      UIApplication.shared.open(youtubeUrl)
    } else{
      youtubeUrl = URL(string:"https://www.youtube.com/watch?v=\(youtubeId)")!
      UIApplication.shared.open(youtubeUrl)
    }
  }
  
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellViewModel = self.viewModel.detailCellViewModels[indexPath.row]
    switch cellViewModel.type {
    case .horizantal:
      if let cell = tableView.dequeueReusableCell(withIdentifier: "HorizantalListTVC", for: indexPath) as? HorizantalListTVC {
        cell.configureCell(viewModel: cellViewModel)
        cell.delegate = self
        return cell
      }
    case .movieOverview:
      if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDescriptionTVC", for: indexPath) as? MovieDescriptionTVC {
        cell.configure(viewModel: cellViewModel)
        return cell
      }
    }
    return UITableViewCell()
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.viewModel.detailCellViewModels.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let cellViewModel = self.viewModel.detailCellViewModels[indexPath.row]
    return cellViewModel.cellHeight
  }
  
}

extension MovieDetailViewController: HorizantalListCellDelegate {
  func showAllList(movieViewModelList: [SingleMovieCellViewModelable], listType: HorizantalListType) {  }
  
  func showMovieDetail(movie: Movie) {
    let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
    let detailviewModel = MovieDetailViewModel(movie: movie)
    detailVC.viewModel = detailviewModel
    self.present(detailVC, animated: true, completion: nil)
  }
}
