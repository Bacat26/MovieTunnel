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
}

extension HighlightsViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.viewModel.highlightListCellViewModels.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "HorizantalListTVC", for: indexPath) as? HorizantalListTVC {
      cell.configureCell(viewModel: self.viewModel.highlightListCellViewModels[indexPath.row])
      return cell
    }
    return UITableViewCell()
  }
}
