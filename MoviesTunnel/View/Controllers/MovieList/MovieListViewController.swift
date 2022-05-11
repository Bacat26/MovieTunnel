//
//  MovieListViewController.swift
//  MoviesTunnel
//
//  Created by bilal acat on 11.05.2022.
//

import UIKit
import Alamofire

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

protocol MovieListViewModelable {
  var reloadAll: (() -> ())? { get set }
  var scrollToTop: (() -> ())? { get set }
  var updateSectionLayout: ((HighligtsMoviesType) -> ())? { get set }
  var stillLoading: Bool { get }
  var listType: HighligtsMoviesType { get }
  var pageInfo: PageInfo { get }
  
  func fetchMovieList()
  func numberOfItem() -> Int
  func getCellViewModel(indexPath: IndexPath) -> SingleMovieCellViewModelable
  func collectionCellSize() -> CGSize
  func changeListType(movieType: HighligtsMoviesType)
}

class MovieListViewModel: MovieListViewModelable {
  
  var pageInfo: PageInfo = PageInfo()
  private var movieViewModelList: [SingleMovieCellViewModelable]
  private var client: WebServiceProtocol = WebService()
  
  var reloadAll: (() -> ())?
  var scrollToTop: (() -> ())?
  var updateSectionLayout: ((HighligtsMoviesType) -> ())?
  var stillLoading: Bool = false
  var listType: HighligtsMoviesType
  
  let cellInteritemSpacing: CGFloat! = 10
  private let coloumnCount: Int = 3
  
  init(initial movieList: [SingleMovieCellViewModelable], listType: HighligtsMoviesType) {
    movieViewModelList = movieList
    pageInfo.increasePageNumber()
    stillLoading = false
    self.listType = listType
    addPlaceHolderCellViewModel()
  }
  
  private func addPlaceHolderCellViewModel() {
    removePlaceHolderCellViewModelIfNeeded()
    let placeholderCellViewModel = SingleMovieCellViewModel(movie: nil, isPlaceholder: true)
    for _ in 0...2 { self.movieViewModelList.append(placeholderCellViewModel) }
  }
  
  func removePlaceHolderCellViewModelIfNeeded() {
    self.movieViewModelList.removeAll(where: { $0.isPlaceHolder })
  }
  
  func fetchMovieList() {
    stillLoading = true
    switch self.listType {
    case .topRated:
      client.getTopRatedMovies(pageIndex: self.pageInfo.nextPage, completion: apiMethodsCompletion())
    case .popular:
      client.getPopularMovies(pageIndex: self.pageInfo.nextPage, completion: apiMethodsCompletion())
    case .upcoming:
      client.getUpcomingMovies(pageIndex: self.pageInfo.nextPage, completion: apiMethodsCompletion())
    }
  }
  
  func apiMethodsCompletion() -> ((Result<MovieResponseModel, AFError>) -> Void) {
    return { [weak self] response in
      guard let self = self else { return }
      switch response {
      case .success(let result):
        let movieList = result.results
        self.movieViewModelList.append(contentsOf: movieList.compactMap({ SingleMovieCellViewModel(movie: $0) as? SingleMovieCellViewModelable }))
        self.addPlaceHolderCellViewModel()
        self.pageInfo = PageInfo(with: result)
        self.reloadAll?()
        self.stillLoading = false
        if self.pageInfo.currentPage == 1 { self.scrollToTop?() }
      case .failure(let error):
        print("Error: ", error.errorDescription ?? "")
      }
    }
  }
  
  func numberOfItem() -> Int {
    return self.movieViewModelList.count
  }
  
  func getCellViewModel(indexPath: IndexPath) -> SingleMovieCellViewModelable {
    return self.movieViewModelList[indexPath.item]
  }
  
  func collectionCellSize() -> CGSize {
    let screenWidth = UIScreen.main.bounds.width
    let spaceCount = coloumnCount + 1
    let totalSpace: CGFloat = CGFloat(spaceCount) * cellInteritemSpacing
    let cellWidth = (screenWidth - totalSpace) / CGFloat(coloumnCount)
    let cellHeight = cellWidth * 1.5
    return CGSize(width: cellWidth, height: cellHeight)
  }
  
  func changeListType(movieType: HighligtsMoviesType) {
    guard movieType != listType else { return }
    pageInfo = PageInfo()
    self.listType = movieType
    self.movieViewModelList.removeAll()
    self.fetchMovieList()
    self.updateSectionLayout?(movieType)
  }
}
