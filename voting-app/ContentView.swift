//
//  ContentView.swift
//  voting-app
//
//  Created by Kamaal Farah on 08/10/2019.
//  Copyright © 2019 Kamaal. All rights reserved.
//


import SwiftUI


let baseUrl = "http://localhost:8000"


struct ContentView: View {
    @State private var sessionTitleTextField = ""
    @State private var sessionTitle = ""

    @State private var qrCodeUrlFetched = false
    @State private var qrCodePath = "https://github.com/kamaal111"

    @State private var candidatesTextField = ""
    @State private var candidatesList = [Candidate]()


    let fetch = Fetch(baseUrl: baseUrl)


    func submitSessionTitle() -> Void {
        if !self.sessionTitleTextField.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty
            && self.sessionTitleTextField.count > 2 {
            self.sessionTitle = String(self.sessionTitleTextField.prefix(15))
            self.sessionTitleTextField = ""
        }
    }


    func submitCandidateToList() -> Void {
        if !self.candidatesTextField.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty
            && self.candidatesTextField.count > 2 {
            let candidate = Candidate(
                id: candidatesList.count + 1,
                name: self.candidatesTextField
            )
            self.candidatesList.append(candidate)
            self.candidatesTextField = ""
        }
    }


    fileprivate func StartSessionButton(text: String) -> Button<Text> {
        return Button(action: {
            var candidates = [[String:String]]()

            for candidate in self.candidatesList {
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
            Text(text)
        })
    }


    var body: some View {
        VStack {
            if qrCodeUrlFetched {
                Text("Time to vote")
                Image(nsImage: generateQRCode(from: qrCodePath, size: 10)!)
                    .padding(EdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0))
                Button(action: { print(self.qrCodePath) }, label: { Text("qrCodePath") })
            } else {
                HStack {
                    VStack {
                        Text("Candidates").font(Font.title)
                        HStack {
                            Text("Name:")
                            TextField("", text: $candidatesTextField, onCommit: {
                                self.submitCandidateToList()
                            })
                            Button(action: {
                                self.submitCandidateToList()
                            }, label: {
                                Text("Submit")
                            }).disabled(
                                !self.candidatesTextField.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty
                                    && self.candidatesTextField.count > 2 ? false : true
                            )
                        }

                        List(self.candidatesList, id: \.id) { candidate in
                            Text(candidate.name)
                        }
                    }
                    VStack {
                        HStack{
                            if self.sessionTitle.isEmpty {
                                Text("Session Title:")
                                TextField("", text: $sessionTitleTextField, onCommit: {
                                    self.submitSessionTitle()
                                })
                                Button(action: {
                                    self.submitSessionTitle()
                                }, label: {
                                    Text("Submit")
                                }).disabled(
                                    !self.sessionTitleTextField.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty
                                        && self.sessionTitleTextField.count > 2 ?
                                            false : true
                                )
                            }
                        }
                        Text(sessionTitle).font(Font.title)
                        StartSessionButton(text: "Start Session").disabled(
                            !self.sessionTitle.isEmpty
                                && self.candidatesList.count > 1 ? false : true
                        )
                    }
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
