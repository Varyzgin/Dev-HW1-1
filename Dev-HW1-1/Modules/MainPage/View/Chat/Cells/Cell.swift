//
//  Cell.swift
//  Dev-HW1-1
//
//  Created by Дима on 2/12/25.
//

import UIKit

final class Cell: UICollectionViewCell {
    public static let identifier = "Cell"
    
    override func prepareForReuse() {
        super.prepareForReuse()
        messageLabel.textColor = nil
        textFieldBackground.backgroundColor = nil
        messageLabel.text = nil
        tokensLabel.text = nil
        moneyLabel.text = nil
        NSLayoutConstraint.deactivate([
            textFieldBackground.widthAnchor.constraint(lessThanOrEqualToConstant: Parameters.screenWidth - 4 * Margins.M),
            textFieldBackground.widthAnchor.constraint(greaterThanOrEqualTo: messageLabel.widthAnchor),
            textFieldBackground.leadingAnchor.constraint(greaterThanOrEqualTo: transpView.leadingAnchor, constant: 2 * Margins.M),
//            textFieldBackground.leadingAnchor.constraint(equalTo: transpView.leadingAnchor),
//            textFieldBackground.widthAnchor.constraint(equalToConstant: Parameters.screenWidth - 2 * Margins.M)
        ])
    }
    
    public func configure(with message: ChatMessage) {
        messageLabel.text = message.content
        if message.type == .PROMPT {
            messageLabel.textColor = .white
            textFieldBackground.backgroundColor = .systemBlue
            NSLayoutConstraint.activate([
                textFieldBackground.widthAnchor.constraint(lessThanOrEqualToConstant: Parameters.screenWidth - 4 * Margins.M),
                textFieldBackground.widthAnchor.constraint(greaterThanOrEqualTo: messageLabel.widthAnchor),
                textFieldBackground.leadingAnchor.constraint(greaterThanOrEqualTo: transpView.leadingAnchor, constant: 2 * Margins.M)
            ])
        } else {
            textFieldBackground.backgroundColor = .systemGray6
            textFieldBackground.leadingAnchor.constraint(equalTo: transpView.leadingAnchor).isActive = true
            textFieldBackground.widthAnchor.constraint(equalToConstant: Parameters.screenWidth - 2 * Margins.M).isActive = true
        }
//        textFieldBackground.backgroundColor = (message.type == .PROMPT) ? .systemBlue : .systemGray6
        
        if let promptTokens = message.promptTokens, let answerTokens = message.answerTokens, let money = message.money {
            tokensLabel.text = "Tokens: \(promptTokens)/\(answerTokens)"
            moneyLabel.text = "Money: \(money)"
        }
    }

    private lazy var transpView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private lazy var textFieldBackground = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 34 / 2
        return $0
    }(UIView())

    private lazy var messageLabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.font = TextStyle.description
        return $0
    }(UILabel())
    
    private lazy var tokensLabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .left
        $0.textColor = .systemGray2
        $0.font = TextStyle.subDescription
        return $0
    }(UILabel())
    
    private lazy var moneyLabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .right
        $0.textColor = .systemGray2
        $0.font = TextStyle.subDescription

        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(transpView)
        transpView.addSubview(textFieldBackground)
        textFieldBackground.addSubviews(messageLabel, tokensLabel, moneyLabel)
        
        NSLayoutConstraint.activate([
            transpView.topAnchor.constraint(equalTo: contentView.topAnchor),
            transpView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            transpView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            transpView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            transpView.widthAnchor.constraint(equalToConstant: Parameters.screenWidth - Margins.M * 2),
    
            textFieldBackground.topAnchor.constraint(equalTo: transpView.topAnchor),
//            textFieldBackground.leadingAnchor.constraint(greaterThanOrEqualTo: transpView.leadingAnchor, constant: 2 * Margins.M),
            textFieldBackground.trailingAnchor.constraint(equalTo: transpView.trailingAnchor),
            textFieldBackground.bottomAnchor.constraint(equalTo: transpView.bottomAnchor),
//            textFieldBackground.widthAnchor.constraint(lessThanOrEqualToConstant: Parameters.screenWidth - 4 * Margins.M),
//            textFieldBackground.widthAnchor.constraint(greaterThanOrEqualTo: messageLabel.widthAnchor),
            
            messageLabel.topAnchor.constraint(equalTo: textFieldBackground.topAnchor, constant: Margins.XS),
            messageLabel.leadingAnchor.constraint(equalTo: textFieldBackground.leadingAnchor, constant: Margins.S),
            messageLabel.trailingAnchor.constraint(equalTo: textFieldBackground.trailingAnchor, constant: -Margins.S),
//            messageLabel.bottomAnchor.constraint(equalTo: textFieldBackground.bottomAnchor, constant: -Margins.XS),
            
            tokensLabel.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: Margins.XS),
            tokensLabel.leadingAnchor.constraint(equalTo: textFieldBackground.leadingAnchor, constant: Margins.S),
            tokensLabel.bottomAnchor.constraint(equalTo: textFieldBackground.bottomAnchor, constant: -Margins.XS),
            
            moneyLabel.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: Margins.XS),
            moneyLabel.leadingAnchor.constraint(equalTo: tokensLabel.trailingAnchor, constant: Margins.S),
            moneyLabel.trailingAnchor.constraint(equalTo: textFieldBackground.trailingAnchor, constant: -Margins.S),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
