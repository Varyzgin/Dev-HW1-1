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
        
        var textMessages : [TextRequest.Message] = []
        textMessages.append(TextRequest.Message(role: "user", content: prompt))
        let textRequest = TextRequest(model: "gpt-4o", messages: textMessages)
        
        do {
            let body = try JSONEncoder().encode(textRequest)
            request.httpBody = body
        } catch {
            print("Error")
        }
        URLSession.shared.dataTask(with: request) {data, _, error in
            guard error == nil, let data = data else { return }
            do {
                let response = try JSONDecoder().decode(TextResponse.self, from: data)
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
    
    func requestPicture(prompt: String, path: String, completion: @escaping (Item) -> Void) {
        var urlComponents = URLComponents(string: URL)
        urlComponents?.path = path
        
        var request = URLRequest(url: urlComponents!.url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let pictureRequest = PictureRequest(model: "dall-e-3", prompt: prompt, n: 1, size: "1024x1024")
        do {
            let body = try JSONEncoder().encode(pictureRequest)
            request.httpBody = body
        } catch {
            print ("Error encoding JSON")
        }
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil, let data = data else { return }
            
            do {
                let response = try JSONDecoder().decode(PictureResponse.self, from: data)
                completion(Item(content: response.data[0].revised_prompt, type: .PICTURE, imageURL: response.data[0].url))
            } catch {
                print("Error decoding JSON")
            }
        }.resume()
    }
    func downloadImage(from url: URL, completion: @escaping (Data) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else { return }
            completion(data)
        }.resume()
    }
}
