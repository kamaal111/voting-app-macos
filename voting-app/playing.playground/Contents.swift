
import AppKit
import Foundation


let baseUrl = "http://localhost:5000"


// QR code generator
func generateQRCode(from string: String, size: CGFloat) -> NSImage? {
    let data = string.data(using: String.Encoding.ascii)

    if let filter = CIFilter(name: "CIQRCodeGenerator") {
        filter.setValue(data, forKey: "inputMessage")
        let transform = CGAffineTransform(scaleX: size, y: size)

        if let output = filter.outputImage?.transformed(by: transform) {
            let representation = NSCIImageRep(ciImage: output)
            let qrCode = NSImage(size: representation.size)
            qrCode.addRepresentation(representation)

            return qrCode
        }
    }
    return nil
}


generateQRCode(from: baseUrl, size: 10)


// http requests
struct HTTPRequest {
    var baseUrl: String


    // GET request
    func getRequest(at baseUrl: String, path: String, completion: @escaping (_ res: [String: Any]) -> Void) {
        guard let url = URL(string: "\(baseUrl)/\(path)") else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data, error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return
            }
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                if let response = response as? HTTPURLResponse {
                    completion(["status": response.statusCode, "data": jsonResponse] as? [String : Any] ?? [:])
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }


    // POST request
    func postRequest(at baseUrl: String, path: String, send body: [String: Any], completion: @escaping (_ res: [String: Any]) -> Void) {
        guard let url = URL(string: "\(baseUrl)/\(path)") else { return }

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
                    completion(["status": response.statusCode, "data": jsonResponse] as? [String : Any] ?? [:])
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
}


let fetch = HTTPRequest(baseUrl: baseUrl)

fetch.getRequest(at: baseUrl, path: "test",completion: {
    (res: Any) in print(res)
})

let sendBody: [String: Any] = [
    "name": "new_session",
    "candidates": [
        "name": "someone",
        "votes": []
    ]
]

fetch.postRequest(at: baseUrl, path: "test", send: sendBody, completion: {
    (res: Any) in print(res)
})






