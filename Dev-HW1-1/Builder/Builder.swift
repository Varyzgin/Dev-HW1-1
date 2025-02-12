//
//  Builder.swift
//  Dev-HW1-1
//
//  Created by Дима on 2/4/25.
//

import UIKit

class Builder {
    static func makeViewController() -> UIViewController {
        let vc = MainPageViewController()
        let presenter = MainPagePresenter(view: vc)
        vc.presenter = presenter
        return vc
    }
}
