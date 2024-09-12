//
//  SendEmailVerification.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/10/24.
//

import Vapor

struct SendEmailVerification {
    struct Request: Content {
        let email: String
    }
}
