//
//  Register.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/10/24.
//

import Vapor

struct Register {
    struct Request: Content {
        let fullName: String
        let email: String
        let password: String
        let confirmPassword: String
    }
}

extension Register.Request: Validatable  {
    static func validations(_ validations: inout Validations) {
        validations.add("fullName", as: String.self, is: .count(3...))
        validations.add("email", as: String.self, is: .email)
        validations.add("password", as: String.self, is: .count(8...))
    }
}

extension User {
    convenience init(from register: Register.Request, hash: String) throws {
        self.init(fullName: register.fullName, email: register.email, passwordHash: hash)
    }
}

