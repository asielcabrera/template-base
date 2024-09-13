//
//  VerificationEmail.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/12/24.
//


struct VerificationEmail: Email {
    var templateName: String
    let verifyUrl: String
    
    var subject: String {
        "Please verify your email"
    }
    
    var templateData: [String : String]
    
    init(verifyUrl: String) {
        self.verifyUrl = verifyUrl
        self.templateName = "email_verification"
        self.templateData = ["verify_url": verifyUrl]
    }
    
    
    mutating func append(key: String, value: String) {
        self.templateData.updateValue(value, forKey: key)
    }
}