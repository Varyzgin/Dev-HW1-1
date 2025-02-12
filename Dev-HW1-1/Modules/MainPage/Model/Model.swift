//
//  TestRequest.swift
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

@objc enum ActionType : Int {
    case FORGET, REQUEST
}

struct ChatMessage {
    let content: String
    let type: MessageType
    var promptTokens: Int? = nil
    var answerTokens: Int? = nil
    var money: Double? = nil
    var imageURL: String? = nil
    
    public static func mock() -> [ChatMessage] {
        Constants.items
    }
}

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

struct Network {
    struct TextRequest: Encodable {
        let model: String
        let messages: [Message]
        
        struct Message: Codable {
            let role: String
            let content: String
        }
    }

    struct PictureRequest: Encodable {
        let model: String
        let prompt: String
        let n: Int
        let size: String
    }

    struct GeneralResponseStructure: Decodable {
        // for text response
        let id: String?
        let choices: [Choice]?
        let usage: Usage?
        struct Choice: Decodable {
            let message: Message

            struct Message: Codable {
                let content: String
            }
        }
        struct Usage: Decodable {
            let prompt_tokens: Int
            let completion_tokens: Int
            let total_tokens: Int
        }
        
        // for picture response
        let data: [Data]?
        struct Data: Decodable {
            let revised_prompt: String
            let url: String
        }
    }

}
