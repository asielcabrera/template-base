//
//  RecoverAccountAction.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/12/24.
//

import Vapor
import Fluent

struct RecoverAccountAction: Action {

    func execute(req: Request, input: Recovery.AccountRequest) async throws -> HTTPStatus {
        guard input.password == input.confirmPassword else {
            throw AuthenticationError.passwordsDontMatch
        }
        
        let hashedToken = SHA256.hash(input.token)
        
        guard let passwordToken = try await req.passwordTokens.find(token: hashedToken) else {
            throw AuthenticationError.invalidPasswordToken
        }
        
        guard passwordToken.expiresAt > .now else {
            try await req.passwordTokens.delete(id: passwordToken.requireID())
            throw AuthenticationError.passwordTokenHasExpired
        }
        
        let digest = try await req.password.async.hash(input.password)
        try await req.users.set(\.$passwordHash, to: digest, for: passwordToken.$user.id)
        try await req.passwordTokens.delete(id: passwordToken.$user.id)
        
        return .noContent
        
    }
}
