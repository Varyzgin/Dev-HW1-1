//
//  ChatViewController.swift
//  Dev-HW1-1
//
//  Created by Дима on 2/4/25.
//

import UIKit

final class Chat: UICollectionView {
    var history : [ChatMessage]
    
    init(frame: CGRect, history: [ChatMessage] = []) {
        self.history = history
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())

        let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        self.contentInsetAdjustmentBehavior = .never
        self.contentInset = UIEdgeInsets(top: 150 + Margins.S, left: Margins.M, bottom: Margins.L, right: Margins.M)//!!!!!!!!!!! top to change
        self.dataSource = self
        self.register(Cell.self, forCellWithReuseIdentifier: Cell.identifier)
//        self.register(AnswerCellView.self, forCellWithReuseIdentifier: AnswerCellView.identifier)
        self.register(PictureCellView.self, forCellWithReuseIdentifier: PictureCellView.identifier)
        
        self.frame = frame
        self.collectionViewLayout = layout
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Chat : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.history.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if indexPath.row == self.history.count - 1 {
//            self.scrollToItem(at: indexPath, at: .bottom, animated: true)
//        }
            
        switch self.history[indexPath.row].type {
        case .PROMPT:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as? Cell
            else { return UICollectionViewCell() }
            cell.configure(with: self.history[indexPath.row])
            return cell
            
        case .ANSWER:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as? Cell
            else { return UICollectionViewCell() }
            cell.configure(with: self.history[indexPath.row])
            return cell
            
        case .PICTURE:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PictureCellView.identifier, for: indexPath) as? PictureCellView
            else { return UICollectionViewCell() }
            if let imageURL = self.history[indexPath.row].imageURL {
                cell.configure(message: self.history[indexPath.row].content, image: imageURL)
            }
            return cell
        }
    }
}
