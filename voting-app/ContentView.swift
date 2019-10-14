//
//  ContentView.swift
//  voting-app
//
//  Created by Kamaal Farah on 08/10/2019.
//  Copyright © 2019 Kamaal. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    let qrCode = generateQRCode(from: "google.com")

    var body: some View {
        VStack {
            Text("Time to vote")
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            Image(nsImage: qrCode!)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
