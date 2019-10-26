//
//  RegistrationView.swift
//  voting-app
//
//  Created by Kamaal Farah on 26/10/2019.
//  Copyright © 2019 Kamaal. All rights reserved.
//


import SwiftUI


struct RegistrationView: View {
    @State private var candidatesTextField = ""
    @State private var candidatesList = [Candidate]()
    
    @Binding var qrCodePath: String
    @Binding var qrCodeUrlFetched: Bool


    var body: some View {
        HStack {
            CandidatesSection(
                candidatesTextField: $candidatesTextField,
                candidatesList: $candidatesList
            )
            SessionTitleSection(
                candidatesList: self.candidatesList, qrCodePath: $qrCodePath,
                qrCodeUrlFetched: $qrCodeUrlFetched
            )
        }
    }
}

