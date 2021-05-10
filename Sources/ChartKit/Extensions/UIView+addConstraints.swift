//
//  File.swift
//  
//
//  Created by Mirsaid Patarov on 2021-05-10.
//

import UIKit

extension UIView {
  func addConstraints(withVisualFormat format: String, options opts: NSLayoutConstraint.FormatOptions = [], views: UIView...) {
    var viewsDictionary = [String: UIView]()

    for (index, view) in views.enumerated() {
      let key = "v\(index)"
      view.translatesAutoresizingMaskIntoConstraints = false
      viewsDictionary[key] = view
    }

    addConstraints(
      NSLayoutConstraint.constraints(
        withVisualFormat: format,
        options: opts,
        metrics: nil,
        views: viewsDictionary
      )
    )
  }
}
