//
//  ViewController.swift
//  Dev-HW1-1
//
//  Created by Дима on 1/17/25.
//

import UIKit

class ViewController: UIViewController {
    private let URL = "https://bothub.chat"
    private let pathForTextGeneration = "/api/v2/openai/v1/chat/completions"
    private let pathForPictureGeneration = "/api/v2/openai/v1/images/generations"
    private let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdhNWVmMzI0LTc1NmUtNDVlOC04YWYxLTFlMWNkMDRkMDE1NyIsImlzRGV2ZWxvcGVyIjp0cnVlLCJpYXQiOjE3MzUzOTA3NjIsImV4cCI6MjA1MDk2Njc2Mn0.xL2fhtLOtHp_K4Xn_bEAhuKgnRwYlUGwaRk-XxirgdY"
    
    private var moneySum: Double = 0
    private var promptType = PromptType.TEXT
    
    private lazy var networkManager = NetworkManager(URL: URL, token: token)
    private var storage : [Item] = // Item.mock()
    [] {
        willSet {
            DispatchQueue.main.async {
                self.moneySumLabel.text = "Spent: \(String(format: "%.2f", self.moneySum))₱"
                self.collectionView.reloadData()
            }
        }
    }
    private let sendButtonSize = 35
    
    @objc func processPrompt() {
        if var prompt = self.textField.text {
            if prompt == "" { return }
//        clear input
            self.textField.text = nil
//        hide keyboard
            view.endEditing(true)
//        store
            self.storage.append(Item(content: prompt, type: MessageType.PROMPT))
//        loading animation
            self.moneySumLabel.isHidden = true
            self.activityIndicatorView.startAnimating()
//        send / receive / store
            switch self.promptType {
            case .TEXT:
                self.networkManager.requestText(dialogHistory: storage, path: pathForTextGeneration) { response in
                    self.storage.append(response)
                    
                    self.moneySum += response.money ?? 0
                    
                    DispatchQueue.main.async {
                        self.activityIndicatorView.stopAnimating()
                    }
                    DispatchQueue.main.async {
                        self.moneySumLabel.isHidden = false
                    }
                }
            case .PICTURE:
                if storage.count > 1 {
                    prompt += " " + storage[storage.count - 2].content
                    print(prompt)
                }
                self.networkManager.requestPicture(prompt: prompt, path: pathForPictureGeneration, completion: { response in
                    
                    self.storage.append(response)
                    self.moneySum += 4
                    DispatchQueue.main.async {
                        self.activityIndicatorView.stopAnimating()
                    }
                    DispatchQueue.main.async {
                        self.moneySumLabel.isHidden = false
                    }
                })
            }
            
        }
    }

    private lazy var moneySumLabel = {
        $0.font = TextStyle.description
        $0.textAlignment = .right
        $0.textColor = .systemGray2
        return $0
    }(UILabel(frame: CGRect(x: Int(inputBar.frame.maxX - Margins.S) - 100, y: Int(textFieldBackground.frame.minY - Margins.S - 30), width: 100, height: 30)))

    private lazy var forgetButton = {
        $0.setImage(UIImage(systemName: "trash"), for: .normal)
        $0.addAction(UIAction{_ in 
            self.storage.removeAll()
            self.moneySum = 0
        },for: .touchUpInside)
        return $0
    }(UIButton(frame: CGRect(x: Int(Margins.S), y: Int(textFieldBackground.frame.minY - Margins.S - 30), width: 30, height: 30)))
    
    private lazy var segmentedControl = {
        $0.insertSegment(withTitle: "Text", at: 0, animated: false)
        $0.insertSegment(withTitle: "Picture", at: 1, animated: false)
        $0.selectedSegmentIndex = 0
        $0.addTarget(self, action: #selector(chooseType), for: .valueChanged)
        return $0
    }(UISegmentedControl(frame: CGRect(x: Int(inputBar.frame.midX) - 60, y: Int(textFieldBackground.frame.minY - Margins.S - 30), width: 120, height: 30)))
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
//        $0.hidesWhenStopped = true
        return $0
    }(UIActivityIndicatorView(frame: CGRect(x: Int(inputBar.frame.maxX - Margins.S) - 30, y: Int(textFieldBackground.frame.minY - Margins.S - 30), width: 30, height: 30)))
    
    private lazy var textField: UITextField = {
        $0.placeholder = "Prompt"
        $0.becomeFirstResponder()
        return $0
    }(UITextField(frame: CGRect(x: Int(Margins.S), y: 0, width: Int(textFieldBackground.frame.width - 2 * Margins.S), height: sendButtonSize)))
    
    private lazy var textFieldBackground = {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .secondarySystemFill
        return $0
    }(UIView(frame: CGRect(x: Int(Margins.S), y: Int(inputBar.frame.maxY - Margins.S) - sendButtonSize, width: Int(inputBar.frame.width - 2 * Margins.S - Margins.XS) - sendButtonSize, height: sendButtonSize)))
    
    private lazy var sendButton = {
        $0.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        $0.addTarget(self, action: #selector(processPrompt), for: .touchUpInside)
        return $0
    }(UIButton(frame: CGRect(x: Int(inputBar.frame.maxX - Margins.S) - sendButtonSize, y: Int(inputBar.frame.maxY - Margins.S) - sendButtonSize, width: sendButtonSize, height: sendButtonSize)))
    
    private lazy var inputBar = {
        $0.backgroundColor = .systemBackground
        return $0
    }(UIView(frame: CGRect(origin: .zero, size: CGSize(width: view.frame.width, height: 150))))

    @objc func chooseType(sender: UISegmentedControl) {
        promptType = sender.selectedSegmentIndex == 0 ? .TEXT : .PICTURE
    }
    
    private func setupInputBar() {
        inputBar.addSubview(activityIndicatorView)
        inputBar.addSubview(forgetButton)
        inputBar.addSubview(segmentedControl)
        inputBar.addSubview(moneySumLabel)
        inputBar.addSubview(textFieldBackground)
        inputBar.addSubview(sendButton)
        textFieldBackground.addSubview(textField)
    }
    
    private lazy var collectionView = {
        let layout = $0.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        $0.contentInsetAdjustmentBehavior = .never
        $0.contentInset = UIEdgeInsets(top: 150, left: Margins.M, bottom: Margins.L, right: Margins.M)//!!!!!!!!!!! top to change
        $0.dataSource = self
        $0.register(PromptCellView.self, forCellWithReuseIdentifier: PromptCellView.identifier)
        $0.register(AnswerCellView.self, forCellWithReuseIdentifier: AnswerCellView.identifier)
        $0.register(PictureCellView.self, forCellWithReuseIdentifier: PictureCellView.identifier)
        return $0
    }(UICollectionView(frame: view.frame, collectionViewLayout: UICollectionViewFlowLayout()))

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        view.addSubview(inputBar)

        setupInputBar()
    }
}

extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        storage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == self.storage.count - 1 {
            self.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
        }
            
        switch storage[indexPath.row].type {
        case .PROMPT:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromptCellView.identifier, for: indexPath) as? PromptCellView
            else { return UICollectionViewCell() }
            cell.configure(with: storage[indexPath.row])
            return cell
            
        case .ANSWER:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnswerCellView.identifier, for: indexPath) as? AnswerCellView
            else { return UICollectionViewCell() }
            cell.configure(with: storage[indexPath.row])
            return cell
            
        case .PICTURE:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PictureCellView.identifier, for: indexPath) as? PictureCellView
            else { return UICollectionViewCell() }
            if let imageURL = storage[indexPath.row].imageURL {
                cell.configure(message: storage[indexPath.row].content, image: imageURL)
            }
            return cell
        }
    }
}
