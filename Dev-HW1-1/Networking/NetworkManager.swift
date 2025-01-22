//
//  NetworkManager.swift
//  Dev-HW1-1
//
//  Created by Дима on 1/20/25.
//

import Foundation

struct NetworkManager {
    let URL : String
    let token : String
    
    /* """
    {
        "model": "gpt-4o",
        "messages": [
            {
                "role": "user",
                "content": "Tell me about Fiji"
            }
        ],
    }
    """ */
//    var headers : [String : String]
//    let httpMethod : String
    
    func requestText(prompt : String, path: String, completion: @escaping (Item) -> Void) {
        var urlComponents = URLComponents(string: URL)
        urlComponents?.path = path
        var request = URLRequest(url: urlComponents!.url!)
        request.httpMethod = "POST" // API BotHub требует только его
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var testMessages : [TextRequest.Message] = []
        testMessages.append(TextRequest.Message(role: "user", content: prompt))
        let textRequest = TextRequest(model: "gpt-4o", messages: testMessages)
        
        do {
            let body = try JSONEncoder().encode(textRequest)
            request.httpBody = body
        } catch {
            print("Error")
        }
        URLSession.shared.dataTask(with: request) {data, _, error in
            guard error == nil, let data = data else { return }
            do {
                let response = try JSONDecoder().decode(TextResponce.self, from: data)
                completion(Item(
                    content: response.choices[0].message.content,
                    type: .ANSWER,
                    promptTokens: response.usage.prompt_tokens,
                    answerTokens: response.usage.completion_tokens,
                    money: Double(response.usage.total_tokens) * 2 / 10_000
                ))
                print(response.choices[0].message.content)
                print("tokens spent: \(response.usage.total_tokens)")
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
