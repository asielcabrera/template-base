//
//  Recovery.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/10/24.
//

import Vapor

struct Recovery {
    struct AccountRequest: Content {
        let password: String
        let confirmPassword: String
        let token: String
    }
    
    struct ResetPasswordRequest: Content {
        let email: String
    }
}


extension Recovery.AccountRequest: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("password", as: String.self, is: .count(8...))
        validations.add("confirmPassword", as: String.self, is: !.empty)
        validations.add("token", as: String.self, is: !.empty)
    }
}

extension Recovery.ResetPasswordRequest: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("email", as: String.self, is: .email)
    }
}
