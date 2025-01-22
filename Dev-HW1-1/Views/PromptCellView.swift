//
//  PromptCellView.swift
//  Dev-HW1-1
//
//  Created by Дима on 1/21/25.
//

import UIKit

final class PromptCellView: UICollectionViewCell {
    public static let identifier = "PromptCellView"
    
    public func configure(with message: Item) {
        messageLabel.text = message.content
    }

    private lazy var transpView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    private lazy var textFieldBackground = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 34 / 2
        $0.backgroundColor = .systemBlue
        return $0
    }(UIView())

    private lazy var messageLabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .white
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.font = TextStyle.description
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(transpView)
        transpView.addSubview(textFieldBackground)
        textFieldBackground.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            transpView.topAnchor.constraint(equalTo: contentView.topAnchor),
            transpView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            transpView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            transpView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            transpView.widthAnchor.constraint(equalToConstant: Parameters.screenWidth - Margins.M * 2),
    
            textFieldBackground.topAnchor.constraint(equalTo: transpView.topAnchor),
            textFieldBackground.leadingAnchor.constraint(greaterThanOrEqualTo: transpView.leadingAnchor, constant: 2 * Margins.M),
            textFieldBackground.trailingAnchor.constraint(equalTo: transpView.trailingAnchor),
            textFieldBackground.bottomAnchor.constraint(equalTo: transpView.bottomAnchor),
            textFieldBackground.widthAnchor.constraint(lessThanOrEqualToConstant: Parameters.screenWidth - 4 * Margins.M),
            textFieldBackground.widthAnchor.constraint(greaterThanOrEqualTo: messageLabel.widthAnchor),
            
            messageLabel.topAnchor.constraint(equalTo: textFieldBackground.topAnchor, constant: Margins.XS),
            messageLabel.leadingAnchor.constraint(equalTo: textFieldBackground.leadingAnchor, constant: Margins.S),
            messageLabel.trailingAnchor.constraint(equalTo: textFieldBackground.trailingAnchor, constant: -Margins.S),
            messageLabel.bottomAnchor.constraint(equalTo: textFieldBackground.bottomAnchor, constant: -Margins.XS),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
