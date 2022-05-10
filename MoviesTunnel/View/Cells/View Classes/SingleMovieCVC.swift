//
//  SingleMovieCVC.swift
//  MoviesTunnel
//
//  Created by bilal acat on 10.05.2022.
//

import UIKit
import Kingfisher

class SingleMovieCVC: UICollectionViewCell {
  
  @IBOutlet weak var imageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
  }
  
  func configureCell(movie: Movie) {
    var movie = movie
    self.imageView.kf.setImage(with: movie.posterURL, placeholder: UIImage(named: "listPlaceholder")!)
  }
}
