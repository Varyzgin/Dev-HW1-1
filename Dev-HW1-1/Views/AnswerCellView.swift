//
//  PromptCellView.swift
//  Dev-HW1-1
//
//  Created by Дима on 1/21/25.
//

import UIKit

final class AnswerCellView: UICollectionViewCell {
    public static let identifier = "AnswerCellView"
    
    public func configure(with message: Item) {
        messageLabel.text = message.content
        if let promptTokens = message.promptTokens, let answerTokens = message.answerTokens, let money = message.money {
            tokensLabel.text = "Tokens: \(promptTokens)/\(answerTokens)"
            moneyLabel.text = "Money: \(money)"
        }
    }

    private lazy var textFieldBackground = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 34 / 2
        $0.backgroundColor = .systemFill
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
        
        textFieldBackground.addSubview(messageLabel)
        textFieldBackground.addSubview(tokensLabel)
        textFieldBackground.addSubview(moneyLabel)
        contentView.addSubview(textFieldBackground)
        
        NSLayoutConstraint.activate([
            textFieldBackground.topAnchor.constraint(equalTo: contentView.topAnchor),
            textFieldBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textFieldBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textFieldBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            textFieldBackground.widthAnchor.constraint(equalToConstant: Parameters.screenWidth - Margins.M * 2),
            
            messageLabel.topAnchor.constraint(equalTo: textFieldBackground.topAnchor, constant: Margins.XS),
            messageLabel.leadingAnchor.constraint(equalTo: textFieldBackground.leadingAnchor, constant: Margins.S),
            messageLabel.trailingAnchor.constraint(equalTo: textFieldBackground.trailingAnchor, constant: -Margins.S),
            
            tokensLabel.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: Margins.XS),
            tokensLabel.leadingAnchor.constraint(equalTo: textFieldBackground.leadingAnchor, constant: Margins.S),
            tokensLabel.bottomAnchor.constraint(equalTo: textFieldBackground.bottomAnchor, constant: -Margins.XS),
            
            moneyLabel.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: Margins.XS),
            moneyLabel.leadingAnchor.constraint(equalTo: tokensLabel.trailingAnchor, constant: Margins.S),
            moneyLabel.trailingAnchor.constraint(equalTo: textFieldBackground.trailingAnchor, constant: -Margins.S),
//            moneyLabel.bottomAnchor.constraint(equalTo: textFieldBackground.bottomAnchor, constant: -Margins.XS),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
