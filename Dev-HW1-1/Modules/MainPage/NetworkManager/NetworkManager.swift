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
    
    func sendRequest(path: String, httpMethod: String, headers: [String : String], bodyStructure: Encodable, completion: @escaping (Network.GeneralResponseStructure) -> Void) {
        var urlComponents = URLComponents(string: URL)
        urlComponents?.path = path
        
        var request = URLRequest(url: urlComponents!.url!)
        request.httpMethod = httpMethod
        headers.forEach { what, field in
            request.addValue(what, forHTTPHeaderField: field)
        }
        do {
            let body = try JSONEncoder().encode(bodyStructure)
            request.httpBody = body
//            print(body)
        } catch let error as NSError {
            print(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil, let data = data else { return }
            do {
                let response = try JSONDecoder().decode(Network.GeneralResponseStructure.self, from: data)
                completion(response)
            } catch {
                print("\(error) or decoding error")
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
