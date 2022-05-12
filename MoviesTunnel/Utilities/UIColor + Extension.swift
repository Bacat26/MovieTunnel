//
//  UIColor + Extension.swift
//  MoviesTunnel
//
//  Created by bilal acat on 10.05.2022.
//

import UIKit

extension UIColor {
  static func backcround() -> UIColor { return UIColor(named: "Background")! }
  static func titleText() -> UIColor { return UIColor.white }
}

extension UIColor {
  convenience init(_ hex: String, alpha: CGFloat = 1.0) {
      var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
      
      if cString.hasPrefix("#") { cString.removeFirst() }
      
      if cString.count != 6 {
        self.init("ff0000") // return red color for wrong hex input
        return
      }
      
      var rgbValue: UInt64 = 0
      Scanner(string: cString).scanHexInt64(&rgbValue)
      
      self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: alpha)
    }

}
