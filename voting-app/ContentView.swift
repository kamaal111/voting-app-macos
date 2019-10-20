//
//  ContentView.swift
//  voting-app
//
//  Created by Kamaal Farah on 08/10/2019.
//  Copyright © 2019 Kamaal. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    @State private var sessionTitleTextField = ""
    @State private var sessionTitle = ""
    @State private var qrCodeUrlFetched = false
    @State private var qrCodePath = "github.com"


    fileprivate func SessionButton(text: String) -> Button<Text> {
        return Button(action: {
            self.qrCodeUrlFetched = !self.qrCodeUrlFetched
        }, label: {
            Text(text)
        })
    }


    var body: some View {
        VStack {
            if qrCodeUrlFetched {
                Text("Time to vote")
                SessionButton(text: "End Session")
                Image(nsImage: generateQRCode(from: qrCodePath, size: 10)!)
                    .padding(EdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0))
            } else {
                HStack {
                    List {
                        EmptyView()
                    }
                    VStack {
                        HStack{
                            Text("Session Title:")
                            TextField("", text: $sessionTitleTextField, onCommit: {
                                if self.sessionTitleTextField.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty {
                                    print("hello")
                                } else {
                                    self.sessionTitle = self.sessionTitleTextField
                                    self.sessionTitleTextField = ""
                                }
                            })
                        }
                        Text(sessionTitle).font(.title)
                        SessionButton(text: "Start Session")
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
