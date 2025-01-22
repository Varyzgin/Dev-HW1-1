//
//  Storage.swift
//  Dev-HW1-1
//
//  Created by Дима on 1/20/25.
//

enum MessageType {
    case PROMPT, ANSWER, PICTURE
}

enum PromptType {
    case TEXT, PICTURE
}

struct Item {
    let content: String
    let type: MessageType
    var promptTokens: Int? = nil
    var answerTokens: Int? = nil
    var money: Double? = nil
    var imageURL: String? = nil
    
    public static func mock() -> [Item] {
        [
            Item(content: "Hello, World! Hello, World! Hello, World! Hello, World!", type: .PROMPT),
            Item(content: "Hello, World! Hello, World!  Hello, World!  Hello, World!  Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! ", type: .ANSWER, promptTokens: 20, answerTokens: 439, money: 2.75),
            Item(content: "Hello, World! Hello, World! Hello, World! Hello, World!", type: .PROMPT),
            Item(content: "Hello, World! Hello, World!  Hello, World!  Hello, World!  Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! ", type: .ANSWER, promptTokens: 20, answerTokens: 439, money: 2.75),
            Item(content: "Hello, World! Hello, World! Hello, World! Hello, World!", type: .PROMPT),
            Item(content: "Hello, World! Hello, World!  Hello, World!  Hello, World!  Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! ", type: .ANSWER, promptTokens: 20, answerTokens: 439, money: 2.75),
            Item(content: "Hello, World! Hello, World! Hello, World! Hello, World!", type: .PROMPT),
            Item(content: "Hello, World! Hello, World!  Hello, World!  Hello, World!  Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! ", type: .ANSWER, promptTokens: 20, answerTokens: 439, money: 2.75),
        ]
    }
}
