//
//  InputBarPresenter.swift
//  Dev-HW1-1
//
//  Created by Дима on 2/4/25.
//

import Foundation


protocol MainPagePresenterProtocol: AnyObject {
    var chatHistory : [ChatMessage] { get set }
    func processPrompt()
}

final class MainPagePresenter: MainPagePresenterProtocol {
    private weak var view: MainPageViewControllerProtocol?
    
    init(view: MainPageViewControllerProtocol?) {
        self.view = view
    }
    
    internal var moneySum: Double = 0
    
    internal var chatHistory : [ChatMessage] = // Constants.items
    [] {
        willSet {
            DispatchQueue.main.async {
                self.view?.inputBar.moneySumLabel.text = "Spent: \(String(format: "%.2f", self.moneySum))₱"
                print("collection update")
                self.view?.chat.history = self.chatHistory
                self.view?.chat.reloadData()
            }
        }
    }
    
//    private func clearChatHistory() { // starting with button press in inputBarView
//        print("tap")
//        self.view?.inputBar.completion = { type in
//            switch type {
//            case .FORGET:
//                self.chatHistory.removeAll()
//            case .REQUEST:
//                self.processPrompt()
//            }
//        }
//    }
    
    private lazy var networkManager = NetworkManager(URL: Constants.URL, token: Constants.token)
    
    internal func processPrompt() {
        if var prompt = self.view?.inputBar.textField.text {
            if prompt == "" { return }
    //        clear input
            self.view?.inputBar.textField.text = nil
    //        hide keyboard
            self.view?.endEditing(true)
    //        store
            self.chatHistory.append(ChatMessage(content: prompt, type: MessageType.PROMPT))
    //        loading animation
            self.view?.inputBar.moneySumLabel.isHidden = true
            self.view?.inputBar.activityIndicatorView.startAnimating()
    //        send / receive / store
            var headers : [String: String] = [:]
            headers["application/json"] = "Content-Type"
            headers["Bearer \(Constants.token)"] = "Authorization"

            let promptType: PromptType = view?.inputBar.segmentedControl.selectedSegmentIndex == 0 ? PromptType.TEXT : PromptType.PICTURE
            switch promptType {
            case .TEXT:
                var textMessages : [Network.TextRequest.Message] = []
                for item in chatHistory {
                    textMessages.append(Network.TextRequest.Message(role: "user", content: item.content))
                }
                let textRequest = Network.TextRequest(model: "gpt-4o", messages: textMessages)
                
                self.networkManager.sendRequest(path: Constants.textGenPath, httpMethod: "POST", headers: headers, bodyStructure: textRequest, completion: { response in
                    var tokens: Double? = nil
                    if let num = response.usage?.total_tokens {
                        tokens = Double(num) * 200 / 1_000_000
                    } else {
                        print("tokens unwrapping fail")
                    }
                    
                    let message = ChatMessage(
                        content: response.choices?[0].message.content ?? "No content",
                        type: .ANSWER,
                        promptTokens: response.usage?.prompt_tokens,
                        answerTokens: response.usage?.completion_tokens,
                        money: tokens
                    )
                    self.chatHistory.append(message)
                    self.moneySum += message.money ?? 0
                    
                    DispatchQueue.main.async {
                        self.view?.inputBar.activityIndicatorView.stopAnimating()
                    }
                    DispatchQueue.main.async {
                        self.view?.inputBar.moneySumLabel.isHidden = false
                    }
                })
            case .PICTURE:
                if chatHistory.count > 1 {
                    prompt += " " + chatHistory[chatHistory.count - 2].content
                    print(prompt)
                }
                let picRequest = Network.PictureRequest(model: "dall-e-3", prompt: prompt, n: 1, size: "1024x1024")
                
                self.networkManager.sendRequest(path: Constants.textGenPath, httpMethod: "POST", headers: headers, bodyStructure: picRequest, completion: { response in
                    let message = ChatMessage(
                        content: response.data?[0].revised_prompt ?? "No content",
                        type: .PICTURE,
                        imageURL: response.data?[0].url
                    )
                    self.chatHistory.append(message)
                    self.moneySum += 4
                    
                    DispatchQueue.main.async {
                        self.view?.inputBar.activityIndicatorView.stopAnimating()
                    }
                    DispatchQueue.main.async {
                        self.view?.inputBar.moneySumLabel.isHidden = false
                    }
                })
            }
        }
    }
}
