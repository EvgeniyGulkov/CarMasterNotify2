struct Certificates {
    static let carMasterApiCertificate = Certificates.certificate(filename: "carmasterapi")

    private static func certificate(filename: String) -> SecCertificate {
        let filePath = Bundle.main.path(forResource: filename, ofType: "cer")!
        let data = try? Data(contentsOf: URL(fileURLWithPath: filePath))
        let certificate = SecCertificateCreateWithData(nil, (data! as CFData))!
        return certificate
    }
}
