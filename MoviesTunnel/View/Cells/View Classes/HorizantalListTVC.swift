//
//  HorizantalListTVC.swift
//  MoviesTunnel
//
//  Created by bilal acat on 10.05.2022.
//

import UIKit

class HorizantalListTVC: UITableViewCell {
  
  @IBOutlet weak var showAllButton: UIButton!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var collectionView: UICollectionView!
  var viewModel: HorizantalListCellViewModelable?
  weak var delegate: HorizantalListCellDelegate?
  
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
    layout.sectionInset = UIEdgeInsets(top: 4, left: 12, bottom: 4, right: 12)
    layout.itemSize = viewModel!.itemSize
    layout.minimumInteritemSpacing = 10
    collectionView!.collectionViewLayout = layout
  }
  
  func configureCell(viewModel: BaseTableViewCellViewModelable) {
    guard let viewModel = viewModel as? HorizantalListCellViewModelable else {
      fatalError("Can not convert viewModel to HorizantalListCellViewModel")
    }
    self.viewModel = viewModel
    let needShowAllButton = viewModel.listType.showAllEnable
    self.showAllButton.isHidden = !needShowAllButton
    self.setLayout()
    self.titleLabel.text = viewModel.listType.title
    self.collectionView.delegate = self
    self.collectionView.dataSource = self
    self.collectionView.reloadData()
  }
  
  @IBAction func showAllButtonAction(_ sender: Any) {
    delegate?.showAllList(movieViewModelList: self.viewModel?.movieViewModelList ?? [], listType: self.viewModel?.listType ?? .popular)
  }
}

extension HorizantalListTVC: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel?.numberOfColoumn() ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleMovieCVC", for: indexPath) as? SingleMovieCVC {
      if let movieModel = self.viewModel?.getCellViewModel(indexPath: indexPath) {
        cell.configureCell(with: movieModel)
        return cell
      }
    }
    return UICollectionViewCell()
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if let movieModel = self.viewModel?.getCellViewModel(indexPath: indexPath), let movie = movieModel.movie {
      delegate?.showMovieDetail(movie: movie)
    }
  }
}
