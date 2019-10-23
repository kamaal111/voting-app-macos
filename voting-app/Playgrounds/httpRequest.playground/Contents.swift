
import Foundation


let baseUrl = "http://localhost:5000"


// http requests
struct HTTPRequest {
    var baseUrl: String


    // GET request
    func get(path: String, completion: @escaping (_ res: [String: Any]) -> Void) {
        guard let url = URL(string: "\(baseUrl)\(path)") else { return }
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


    // POST request
    func post(path: String, send body: [String: Any], completion: @escaping (_ res: [String: Any]) -> Void) {
        guard let url = URL(string: "\(baseUrl)\(path)") else { return }

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


let fetch = HTTPRequest(baseUrl: baseUrl)

//fetch.get(path: "/test",completion: {
//    (res: Any) in print(res)
//})

let sendBody: [String: Any] = [
    "name": "new_session",
    "candidates": [
        "name": "someone",
        "votes": []
    ]
]

//fetch.post(path: "/test", send: sendBody, completion: {
//    (res: Any) in print(res)
//})
