//
//  UIImageView + Extension.swift
//  MoviesTunnel
//
//  Created by bilal acat on 12.05.2022.
//

import UIKit

extension UIImageView {
  func tintImageColor(color: UIColor) {
    self.image = self.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
    self.tintColorDidChange()
    self.tintColor = color
  }
}
