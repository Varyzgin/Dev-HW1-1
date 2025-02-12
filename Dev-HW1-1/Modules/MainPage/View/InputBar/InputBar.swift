//
//  inputBarController.swift
//  Dev-HW1-1
//
//  Created by Дима on 2/4/25.
//

import UIKit

final class InputBar: UIView {
    let sendButtonSize = 35

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .systemBackground
        self.frame.origin = .zero
        self.frame.size = CGSize(width: self.frame.width, height: 150)
        
        textFieldBackground.addSubview(textField)
        self.addSubviews(activityIndicatorView, forgetButton, segmentedControl, moneySumLabel, textFieldBackground, sendButton)
    }
    
    internal var completion : ((ActionType) -> Void)?
    @objc private func buttonTapped(sender : UIView) {
        switch sender.tag {
        case ActionType.FORGET.rawValue:
            self.completion?(.FORGET)
        case ActionType.REQUEST.rawValue:
            self.completion?(.REQUEST)
        default:
            break
        }
    }
    
    private lazy var forgetButton : UIButton = {
        $0.tag = ActionType.FORGET.rawValue
        $0.setImage(UIImage(systemName: "trash"), for: .normal)
        $0.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return $0
    }(UIButton(frame: CGRect(x: Int(Margins.S), y: Int(textFieldBackground.frame.minY - Margins.S - 30), width: 30, height: 30)))
    
    private lazy var sendButton : UIButton = {
        $0.tag = ActionType.REQUEST.rawValue
        $0.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        $0.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return $0
    }(UIButton(frame: CGRect(x: Int(self.frame.maxX - Margins.S) - sendButtonSize, y: Int(self.frame.maxY - Margins.S) - sendButtonSize, width: sendButtonSize, height: sendButtonSize)))
    
    internal lazy var moneySumLabel : UILabel = {
        $0.font = TextStyle.description
        $0.textAlignment = .right
        $0.textColor = .systemGray2
        return $0
    }(UILabel(frame: CGRect(x: Int(self.frame.maxX - Margins.S) - 100, y: Int(textFieldBackground.frame.minY - Margins.S - 30), width: 100, height: 30)))
    
    internal lazy var segmentedControl : UISegmentedControl = {
        $0.insertSegment(withTitle: "Text", at: 0, animated: false)
        $0.insertSegment(withTitle: "Picture", at: 1, animated: false)
        $0.selectedSegmentIndex = 0
        return $0
    }(UISegmentedControl(frame: CGRect(x: Int(self.frame.midX) - 60, y: Int(textFieldBackground.frame.minY - Margins.S - 30), width: 120, height: 30)))
    
    internal lazy var activityIndicatorView : UIActivityIndicatorView = {
//        $0.hidesWhenStopped = true
        return $0
    }(UIActivityIndicatorView(frame: CGRect(x: Int(self.frame.maxX - Margins.S) - 30, y: Int(textFieldBackground.frame.minY - Margins.S - 30), width: 30, height: 30)))
    
    internal lazy var textField : UITextField = {
        $0.placeholder = "Prompt"
        $0.becomeFirstResponder()
        return $0
    }(UITextField(frame: CGRect(x: Int(Margins.S), y: 0, width: Int(textFieldBackground.frame.width - 2 * Margins.S), height: sendButtonSize)))
    
    private lazy var textFieldBackground : UIView = {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .secondarySystemFill
        return $0
    }(UIView(frame: CGRect(x: Int(Margins.S), y: Int(self.frame.maxY - Margins.S) - sendButtonSize, width: Int(self.frame.width - 2 * Margins.S - Margins.XS) - sendButtonSize, height: sendButtonSize)))

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
