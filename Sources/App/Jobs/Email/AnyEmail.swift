//
//  AnyEmail.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/12/24.
//


struct AnyEmail: Email {
    let templateName: String
    let templateData: [String: String]
    let subject: String
    
    init<E>(_ email: E) where E: Email {
        self.templateData = email.templateData
        self.templateName = email.templateName
        self.subject = email.subject
    }
}