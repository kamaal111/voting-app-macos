//
//  StartSessionButton.swift
//  voting-app
//
//  Created by Kamaal Farah on 26/10/2019.
//  Copyright © 2019 Kamaal. All rights reserved.
//


import SwiftUI


let apiUrl = "http://localhost:8000"


struct StartSessionButton: View {
    let listOfCandidates: [Candidate]
    let sessionTitle: String

    @Binding var qrCodePath: String
    @Binding var qrCodeUrlFetched: Bool


    let fetch = Fetch(baseUrl: apiUrl)


    var body: some View {
        Button(action: {
            var candidates = [[String:String]]()

            for candidate in self.listOfCandidates {
                candidates.append(["name": candidate.name])
            }

            self.fetch.post(path: "/sessions", send: ["name": self.sessionTitle, "candidates": candidates], completion: { (res) in
                switch res {
                case .success(let success):
                    guard let status = success["status"] as? Int else { return }

                    if status != 200 {
                        guard let statusMessage = success["message"] as? String else {
                            print("Oops!")
                            return
                        }

                        print(statusMessage)
                    } else {
                        guard let data = success["data"] as? [String: Any], let sessionID = data["InsertedID"] as? String else {
                            return
                        }

                        self.qrCodePath = "http://localhost:3000/\(sessionID)"
                        self.qrCodeUrlFetched = true
                    }

                case .failure(let failure): print(failure)
                }

            })
        }, label: {
            Text("Start Session")
        })
    }
}
