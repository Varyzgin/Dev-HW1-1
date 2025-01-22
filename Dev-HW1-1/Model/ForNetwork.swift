//
//  TestRequest.swift
//  Dev-HW1-1
//
//  Created by Дима on 1/20/25.
//

let exampleBody =  """
    {
        "model": "gpt-4o",
        "messages": [
            {
                "role": "user",
                "content": "Tell me about Fiji"
            }
        ],
    }
"""

struct TextRequest: Codable {
    let model: String
    let messages: [Message]
    
    struct Message: Codable {
        let role: String
        let content: String
    }
}

struct TextResponse: Codable {
    let id: String
    let choices: [Choice]
    let usage: Usage
    
    struct Choice: Codable {
        let message: Message

        struct Message: Codable {
            let content: String
        }
    }
    
    struct Usage: Codable {
        let prompt_tokens: Int
        let completion_tokens: Int
        let total_tokens: Int
    }
}

struct PictureRequest: Codable {
    let model: String
    let prompt: String
    let n: Int
    let size: String
}

struct PictureResponse: Codable {
    let data: [Data]
    
    struct Data: Codable {
        let revised_prompt: String
        let url: String
    }
}
