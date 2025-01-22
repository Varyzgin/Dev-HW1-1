//
//  Text.swift
//  UIKit-HW8-1
//
//  Created by Дима on 12/10/24.
//

import UIKit

struct TextStyle {
    static let subDescription: UIFont = .systemFont(ofSize: 12 * scaleMultiplier())
    static let description: UIFont = .systemFont(ofSize: 14 * scaleMultiplier())
    static let header: UIFont = .boldSystemFont(ofSize: 16 * scaleMultiplier())
    static let megaHeader: UIFont = .boldSystemFont(ofSize: 20 * scaleMultiplier())
    static let posterTitle: UIFont = .systemFont(ofSize: 24 * scaleMultiplier(), weight: .black)
}
