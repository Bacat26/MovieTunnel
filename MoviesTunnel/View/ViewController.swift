//
//  ViewController.swift
//  MoviesTunnel
//
//  Created by bilal acat on 10.05.2022.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    WebService().getPopularFilms(pageIndex: 1) { response in
      switch response {
      case .success(let result):
        print(result.results.first?.id ?? "Can not find any result")
      case .failure(let error):
        print("Failure: ", error.errorDescription ?? "Unknown Error")
      }
    }
  }


}

