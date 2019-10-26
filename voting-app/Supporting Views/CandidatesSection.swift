//
//  CandidatesSection.swift
//  voting-app
//
//  Created by Kamaal Farah on 26/10/2019.
//  Copyright © 2019 Kamaal. All rights reserved.
//


import SwiftUI


struct CandidatesSection: View {
    @Binding var candidatesTextField: String
    @Binding var candidatesList: [Candidate]


    func submitCandidateToList() {
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


    var body: some View {
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
    }
}

