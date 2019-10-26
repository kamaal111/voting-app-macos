
import Foundation


let baseUrl = "http://localhost:8000"


// http requests
struct HTTPRequest {
    let baseUrl: String


    // GET request
    func get(path: String, completion: @escaping (Result<[String:Any], Error>) -> ()) {
        guard let url = URL(string: "\(self.baseUrl)\(path)") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            do {
                guard let dataResponse = data else { return }

                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                guard let response = response as? HTTPURLResponse else { return }

                let success = ["status": response.statusCode, "data": jsonResponse] as [String : Any]
                completion(.success(success))
            } catch let parsingError {
                completion(.failure(parsingError))
            }
        }.resume()
    }


    // POST request
    func post(path: String, send body: [String: Any], completion: @escaping (Result<[String: Any], Error>) -> ()) {
        guard let url = URL(string: "\(self.baseUrl)\(path)") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            do {
                guard let dataResponse = data else { return }

                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                guard let response = response as? HTTPURLResponse else { return }

                let success = ["status": response.statusCode, "data": jsonResponse] as [String : Any]
                completion(.success(success))
            } catch let parsingError {
                completion(.failure(parsingError))
            }
        }.resume()
    }
}


let fetch = HTTPRequest(baseUrl: baseUrl)

//fetch.get(path: "/sessions",completion: { (res) in
//    switch res {
//    case .success(let success): print(success)
//    case .failure(let failure): print(failure)
//    }
//})

let sendBody: [String: Any] = [
    "name": "new_session",
    "candidates": [
        "name": "someone",
        "votes": []
    ]
]

//fetch.post(path: "/sessions", send: sendBody, completion: { (res) in
//    switch res {
//    case .success(let success): print(success)
//    case .failure(let failure): print(failure)
//    }
//})
