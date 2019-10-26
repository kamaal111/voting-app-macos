//
//  ContentView.swift
//  voting-app
//
//  Created by Kamaal Farah on 08/10/2019.
//  Copyright © 2019 Kamaal. All rights reserved.
//


import SwiftUI


struct ContentView: View {
    @State private var qrCodeUrlFetched = false
    @State private var qrCodePath = "https://github.com/kamaal111"


    var body: some View {
        VStack {
            if qrCodeUrlFetched {
                SessionView(qrCodePath: self.qrCodePath)
            } else {
                RegistrationView(qrCodePath: $qrCodePath, qrCodeUrlFetched: $qrCodeUrlFetched)
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
