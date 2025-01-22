//
//  PromptCellView.swift
//  Dev-HW1-1
//
//  Created by Дима on 1/21/25.
//

import UIKit

final class PictureCellView: UICollectionViewCell {
    public static let identifier = "PictureCellView"
    
    public func configure(message: String, image: String) {
        messageLabel.text = message
        
        if let imageURL = URL(string: image) {
            imageView.load(url: imageURL)
        }
    }

    private lazy var textFieldBackground = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 34 / 2
        $0.backgroundColor = .systemFill
        return $0
    }(UIView())
    
    private lazy var imageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 34 / 2
        $0.clipsToBounds = true
        return $0
    }(UIImageView())

    private lazy var messageLabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.font = TextStyle.description
        return $0
    }(UILabel())

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textFieldBackground.addSubview(imageView)
        textFieldBackground.addSubview(messageLabel)
        contentView.addSubview(textFieldBackground)
        
        NSLayoutConstraint.activate([
            textFieldBackground.topAnchor.constraint(equalTo: contentView.topAnchor),
            textFieldBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textFieldBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textFieldBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            textFieldBackground.widthAnchor.constraint(equalToConstant: Parameters.screenWidth - Margins.M * 2),
            
            imageView.topAnchor.constraint(equalTo: textFieldBackground.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: textFieldBackground.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: textFieldBackground.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: textFieldBackground.widthAnchor),
            
            messageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Margins.M),
            messageLabel.leadingAnchor.constraint(equalTo: textFieldBackground.leadingAnchor, constant: Margins.S),
            messageLabel.trailingAnchor.constraint(equalTo: textFieldBackground.trailingAnchor, constant: -Margins.S),
            messageLabel.bottomAnchor.constraint(equalTo: textFieldBackground.bottomAnchor, constant: -Margins.XS),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
