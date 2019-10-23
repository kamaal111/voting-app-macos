//
//  Fetch.swift
//  voting-app
//
//  Created by Kamaal Farah on 23/10/2019.
//  Copyright © 2019 Kamaal. All rights reserved.
//


import Foundation


struct Fetch {
    var baseUrl: String


    func get(path: String, completion: @escaping (_ res: [String: Any]) -> Void) {
        guard let url = URL(string: "\(self.baseUrl)\(path)") else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data, error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return
            }
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                if let response = response as? HTTPURLResponse {
                    completion(["status": response.statusCode, "data": jsonResponse] as [String : Any])
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }


    func post(path: String, send body: [String: Any], completion: @escaping (_ res: [String: Any]) -> Void) {
        guard let url = URL(string: "\(self.baseUrl)\(path)") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let dataResponse = data, error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return
            }
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                if let response = response as? HTTPURLResponse {
                    completion(["status": response.statusCode, "data": jsonResponse] as [String : Any])
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
}
