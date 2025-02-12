//
//  ViewController.swift
//  Dev-HW1-1
//
//  Created by Дима on 1/17/25.
//

import UIKit

protocol MainPageViewControllerProtocol : AnyObject {
    var inputBar : InputBar { get set }
    var chat : Chat { get set }
    func endEditing(_ bool: Bool)
}

final class MainPageViewController: UIViewController, MainPageViewControllerProtocol {    
    public var presenter: MainPagePresenterProtocol!

    internal lazy var chat = Chat(frame: view.frame, history: presenter.chatHistory)
    internal lazy var inputBar = InputBar(frame: view.frame)
    
    internal func endEditing(_ bool: Bool) {
        view.endEditing(bool)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(chat)
        view.addSubview(inputBar)
        
        self.inputBar.completion = { type in
            print("tap")

            switch type {
            case .FORGET:
                self.presenter.chatHistory.removeAll()
            case .REQUEST:
                self.presenter.processPrompt()
            }
        }
    }
}
