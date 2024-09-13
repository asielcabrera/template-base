//
//  EmailPayload.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/12/24.
//


struct EmailPayload: Codable {
    let email: AnyEmail
    let recipient: String
    
    init<E: Email>(_ email: E, to recipient: String) {
        self.email = AnyEmail(email)
        self.recipient = recipient
    }
}