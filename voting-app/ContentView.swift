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

    let qrCode = generateQRCode(from: "google.com", size: 10)

    var body: some View {
        VStack {

            if qrCodeUrlFetched {
                Text("Time to vote")

                Button(action: {
                    self.qrCodeUrlFetched = !self.qrCodeUrlFetched
                }, label: {
                    Text("End Session")
                })
                
                Image(nsImage: qrCode!)
                    .padding(EdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0))
            } else {
                Button(action: {
                    self.qrCodeUrlFetched = !self.qrCodeUrlFetched
                }, label: {
                    Text("Start Session")
                })

                EmptyView()
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
