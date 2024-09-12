//
//  Login.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/10/24.
//
import Vapor

struct Login {
    struct Request: Content {
        let email: String
        let password: String
    }
    
    struct Response: Content {
        let user: User.Public
        let accessToken: String
        let refreshToken: String
    }
}

extension Login.Request: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("email", as: String.self, is: .email)
        validations.add("password", as: String.self, is: !.empty)
    }
}
