
import AppKit


let baseUrl = "http://localhost:5000"


// QR code generator
func generateQRCode(from string: String, size: CGFloat) -> NSImage? {
    let data = string.data(using: String.Encoding.ascii)

    if let filter = CIFilter(name: "CIQRCodeGenerator") {
        filter.setValue(data, forKey: "inputMessage")
        let transform = CGAffineTransform(scaleX: size, y: size)

        if let output = filter.outputImage?.transformed(by: transform) {
            let representation = NSCIImageRep(ciImage: output)
            let qrCode = NSImage(size: representation.size)
            qrCode.addRepresentation(representation)

            return qrCode
        }
    }
    return nil
}


//generateQRCode(from: baseUrl, size: 10)

