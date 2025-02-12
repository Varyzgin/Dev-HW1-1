//
//  Constants.swift
//  Dev-HW1-1
//
//  Created by Дима on 2/11/25.
//

struct Constants {
    static let URL = "https://bothub.chat"
    static let textGenPath = "/api/v2/openai/v1/chat/completions"
    static let picGenPath = "/api/v2/openai/v1/images/generations"
    static let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdhNWVmMzI0LTc1NmUtNDVlOC04YWYxLTFlMWNkMDRkMDE1NyIsImlzRGV2ZWxvcGVyIjp0cnVlLCJpYXQiOjE3MzUzOTA3NjIsImV4cCI6MjA1MDk2Njc2Mn0.xL2fhtLOtHp_K4Xn_bEAhuKgnRwYlUGwaRk-XxirgdY"

    static let items : [ChatMessage] = [
        ChatMessage(content: "Hello, World! Hello, World! Hello, World! Hello, World!", type: .PROMPT),
        ChatMessage(content: "Hello, World! Hello, World! Hello, World! Hello, World!", type: .PICTURE),
        ChatMessage(content: "Hello, World! Hello, World!  Hello, World!  Hello, World!  Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! ", type: .ANSWER, promptTokens: 20, answerTokens: 439, money: 2.75),
        ChatMessage(content: "Hello, World! Hello, World! Hello, World! Hello, World!", type: .PROMPT),
        ChatMessage(content: "Hello, World! Hello, World!  Hello, World!  Hello, World!  Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! ", type: .ANSWER, promptTokens: 20, answerTokens: 439, money: 2.75),
        ChatMessage(content: "Hello, World! Hello, World! Hello, World! Hello, World!", type: .PROMPT),
        ChatMessage(content: "Hello, World! Hello, World!  Hello, World!  Hello, World!  Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! ", type: .ANSWER, promptTokens: 20, answerTokens: 439, money: 2.75),
        ChatMessage(content: "Hello, World! Hello, World! Hello, World! Hello, World!", type: .PROMPT),
        ChatMessage(content: "Hello, World! Hello, World!  Hello, World!  Hello, World!  Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! ", type: .ANSWER, promptTokens: 20, answerTokens: 439, money: 2.75),
    ]
}
