//
//  HorizantalListTVC.swift
//  MoviesTunnel
//
//  Created by bilal acat on 10.05.2022.
//

import UIKit

class HorizantalListTVC: UITableViewCell {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var collectionView: UICollectionView!
  var viewModel: HorizantalListCellViewModelable?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupCollectionView()
  }
  
  func setupCollectionView() {
    self.collectionView.register(UINib(nibName: "SingleMovieCVC", bundle: nil), forCellWithReuseIdentifier: "SingleMovieCVC")
  }
  
  func setLayout() {
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    layout.itemSize = CGSize(width: 120, height: 180)
    layout.minimumInteritemSpacing = 10
    collectionView!.collectionViewLayout = layout
  }
  
  func configureCell(viewModel: HorizantalListCellViewModelable) {
    self.setLayout()
    self.viewModel = viewModel
    self.titleLabel.text = viewModel.listType.title
    self.collectionView.delegate = self
    self.collectionView.dataSource = self
    self.collectionView.reloadData()
  }
  
  @IBAction func showAllButtonAction(_ sender: Any) {
    
  }
}

extension HorizantalListTVC: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel?.movieList.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleMovieCVC", for: indexPath) as? SingleMovieCVC {
      if let movieModel = self.viewModel?.movieList[indexPath.item] {
        cell.configureCell(movie: movieModel)
        return cell
      }
    }
    return UICollectionViewCell()
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if let selectedMovie = self.viewModel?.movieList[indexPath.item] {
//      let detailVC = MovieDetailVC()
//      detailVC.movieID = selectedMovie.id
    }
//    (self.tabBarController as? MainTabBarController)?.present(with: detailVC)
//    self.navigationController?.pushViewController(detailVC, animated: true)
  }
}
