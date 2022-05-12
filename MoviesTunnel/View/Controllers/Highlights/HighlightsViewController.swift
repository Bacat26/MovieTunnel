//
//  HighlightsViewController.swift
//  MoviesTunnel
//
//  Created by bilal acat on 10.05.2022.
//

import UIKit

class HighlightsViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  var client: WebServiceProtocol = WebService()
  var higlightMovieList = HighlightMovies()
  var horizantalMovieListViewModels: [HorizantalListCellViewModel] = []
  var viewModel: HighlightsViewModelable! = HighlightsViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.backcround()
    setupTableView()
    setupViewModel()
  }
  
  func setupViewModel() {
    self.viewModel = HighlightsViewModel()
    self.viewModel.reloadAll = reloadAllData()
  }
  
  func reloadAllData() -> (() -> ()){
    return { [weak self] in
      guard let self = self else { return }
      self.tableView.reloadData()
    }
  }
  
  func setupTableView() {
    tableView.register(UINib(nibName: "HorizantalListTVC", bundle: nil), forCellReuseIdentifier: "HorizantalListTVC")
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  func showAll() -> (([SingleMovieCellViewModelable]?, HorizantalListType) -> ()) {
    return { [weak self] viewModelList, type in
      guard let viewModelList = viewModelList, let self = self else { return }
      let listViewModel = MovieListViewModel(initial: viewModelList, listType: type)
      let movieListViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieListViewController") as! MovieListViewController
      movieListViewController.viewModel = listViewModel
      self.present(movieListViewController, animated: true, completion: nil)
    }
  }
}

extension HighlightsViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.viewModel.highlightListCellViewModels.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "HorizantalListTVC", for: indexPath) as? HorizantalListTVC {
      cell.configureCell(viewModel: self.viewModel.highlightListCellViewModels[indexPath.row])
      cell.delegate = self
      return cell
    }
    return UITableViewCell()
  }
}

extension HighlightsViewController: HorizantalListCellDelegate, MovieDetailDelegate {
  func showAllList(movieViewModelList: [SingleMovieCellViewModelable], listType: HorizantalListType) {
    let listViewModel = MovieListViewModel(initial: movieViewModelList, listType: listType)
    let movieListViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieListViewController") as! MovieListViewController
    movieListViewController.viewModel = listViewModel
    self.present(movieListViewController, animated: true, completion: nil)
  }
  
  func showMovieDetail(movie: Movie) {
    let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
    let detailviewModel = MovieDetailViewModel(movie: movie)
    detailVC.viewModel = detailviewModel
    detailVC.delegate = self
    self.present(detailVC, animated: true, completion: nil)
  }
  
  func checkFavoriteListChanged() {
    self.viewModel.getFavoriteList()
  }
}
