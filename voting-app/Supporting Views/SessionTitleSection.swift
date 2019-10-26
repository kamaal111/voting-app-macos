//
//  SessionTitleSection.swift
//  voting-app
//
//  Created by Kamaal Farah on 26/10/2019.
//  Copyright © 2019 Kamaal. All rights reserved.
//


import SwiftUI


struct SessionTitleSection: View {
    let candidatesList: [Candidate]

    @Binding var qrCodePath: String
    @Binding var qrCodeUrlFetched: Bool

    @State private var sessionTitleTextField = ""
    @State private var sessionTitle = ""


    func submitSessionTitle() {
        if !self.sessionTitleTextField.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty
            && self.sessionTitleTextField.count > 2 {
            self.sessionTitle = String(self.sessionTitleTextField.prefix(15))
            self.sessionTitleTextField = ""
        }
    }


    var body: some View {
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
            StartSessionButton(
                listOfCandidates: self.candidatesList, sessionTitle: self.sessionTitle,
                qrCodePath: $qrCodePath, qrCodeUrlFetched: $qrCodeUrlFetched
            ).disabled(
                !self.sessionTitle.isEmpty
                    && self.candidatesList.count > 1 ? false : true
            )
        }
    }
}
