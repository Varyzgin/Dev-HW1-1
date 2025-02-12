//
//  UIView.swift
//  Dev-HW1-1
//
//  Created by Дима on 2/12/25.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
