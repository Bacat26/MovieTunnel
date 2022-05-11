//
//  MovieListViewController.swift
//  MoviesTunnel
//
//  Created by bilal acat on 11.05.2022.
//

import UIKit

class MovieListViewController: UIViewController {
  
  @IBOutlet weak var headerLabel: UILabel!
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var headerLineView: UIView!
  @IBOutlet weak var popularSectionButton: UIButton!
  @IBOutlet weak var topRatedSectionButton: UIButton!
  @IBOutlet weak var upcomingSectionButton: UIButton!
  
  var viewModel: MovieListViewModelable!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
    self.setupSectionButtonLayout(listType: self.viewModel.listType)
    self.headerLineView.addShadow(color: .black, opacity: 1, offSet: CGSize(width: 0, height: 4), radius: 16)
    viewModel.reloadAll = self.reloadAllData()
    viewModel.scrollToTop = self.scrollToTop()
    viewModel.updateSectionLayout = self.updateSectionButtonHandler()
    self.collectionView.reloadData()
  }
  
  func setupCollectionView() {
    collectionView.register(UINib(nibName: "SingleMovieCVC", bundle: nil), forCellWithReuseIdentifier: "SingleMovieCVC")
    collectionView.delegate = self
    collectionView.dataSource = self
    setCollectionLayout()
  }
  
  func setCollectionLayout() {
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.sectionInset = UIEdgeInsets(top: 12, left: 10, bottom: 12, right: 10)
    layout.itemSize = viewModel.collectionCellSize()
    layout.minimumInteritemSpacing = 10
    layout.minimumLineSpacing = 10
    collectionView!.collectionViewLayout = layout
  }
  
  @IBAction func popularSectionButtonAction(_ sender: Any) {
    self.viewModel.changeListType(movieType: .popular)
  }
  
  @IBAction func topRatedSectionButtonAction(_ sender: Any) {
    self.viewModel.changeListType(movieType: .topRated)
  }
  
  @IBAction func upcomingSectionButtonAction(_ sender: Any) {
    self.viewModel.changeListType(movieType: .upcoming)
  }
  
}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    print(viewModel?.numberOfItem() ?? 0)
    return viewModel?.numberOfItem() ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleMovieCVC", for: indexPath) as? SingleMovieCVC {
      cell.configureCell(with: viewModel.getCellViewModel(indexPath: indexPath))
      return cell
    }
    return UICollectionViewCell()
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let cellViewModel = viewModel.getCellViewModel(indexPath: indexPath)
    
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let endScrolling = (scrollView.contentOffset.y + scrollView.frame.size.height)
    if endScrolling >= scrollView.contentSize.height / 2 && !self.viewModel.stillLoading && self.viewModel.pageInfo.hasNextPage {
      self.viewModel.fetchMovieList()
    }
  }
  
  func reloadAllData() -> (() -> ()){
    return { [weak self] in
      guard let self = self else { return }
      self.collectionView.reloadData()
    }
  }
  
  func scrollToTop() -> (() -> ()){
    return { [weak self] in
      guard let self = self else { return }
      self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }
  }
  
  func updateSectionButtonHandler() -> ((HighligtsMoviesType) -> ())? {
    return { [weak self] listType in
      guard let self = self else { return }
      self.setupSectionButtonLayout(listType: listType)
    }
  }
  
  func setupSectionButtonLayout(listType: HighligtsMoviesType) {
    switch listType {
    case .popular:
      self.popularSectionButton.setTitleColor(UIColor.white, for: .normal)
      self.popularSectionButton.backgroundColor = .systemRed
      self.topRatedSectionButton.setTitleColor(UIColor.systemRed, for: .normal)
      self.topRatedSectionButton.backgroundColor = .clear
      self.upcomingSectionButton.setTitleColor(UIColor.systemRed, for: .normal)
      self.upcomingSectionButton.backgroundColor = .clear
    case .topRated:
      self.popularSectionButton.setTitleColor(UIColor.systemRed, for: .normal)
      self.popularSectionButton.backgroundColor = .clear
      self.topRatedSectionButton.setTitleColor(UIColor.white, for: .normal)
      self.topRatedSectionButton.backgroundColor = .systemRed
      self.upcomingSectionButton.setTitleColor(UIColor.systemRed, for: .normal)
      self.upcomingSectionButton.backgroundColor = .clear
    case .upcoming:
      self.popularSectionButton.setTitleColor(UIColor.systemRed, for: .normal)
      self.popularSectionButton.backgroundColor = .clear
      self.topRatedSectionButton.setTitleColor(UIColor.systemRed, for: .normal)
      self.topRatedSectionButton.backgroundColor = .clear
      self.upcomingSectionButton.setTitleColor(UIColor.white, for: .normal)
      self.upcomingSectionButton.backgroundColor = .systemRed
    }
  }
}
