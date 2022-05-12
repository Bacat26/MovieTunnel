//
//  MovieDescriptionTVC.swift
//  MoviesTunnel
//
//  Created by bilal acat on 11.05.2022.
//

import UIKit

class MovieDescriptionTVC: UITableViewCell {
  
  @IBOutlet weak var descriptionLabel: UILabel!
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func configure(viewModel: BaseTableViewCellViewModelable) {
    guard let viewModel = viewModel as? MovieDescriptionViewModelable else {
      fatalError("Can not convert viewModel to HorizantalListCellViewModel")
    }
    self.descriptionLabel.text = viewModel.movieDescription
  }
}
