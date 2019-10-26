//
//  SessionView.swift
//  voting-app
//
//  Created by Kamaal Farah on 26/10/2019.
//  Copyright © 2019 Kamaal. All rights reserved.
//


import SwiftUI


struct SessionView: View {
    let qrCodePath: String
    
    var body: some View {
        VStack {
            Text("Time to vote")
            Image(nsImage: generateQRCode(from: self.qrCodePath, size: 10)!)
                .padding(EdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0))
            Button(action: { print(self.qrCodePath) }, label: { Text("qrCodePath") })
        }
    }
}


struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        SessionView(qrCodePath: "https://github.com/kamaal111")
    }
}
