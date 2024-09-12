//
//  VerifyResetPasswordTokenAction.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/12/24.
//

import Vapor
import Fluent

struct VerifyResetPasswordTokenAction: Action {
    typealias Input = String
    typealias Output = HTTPStatus
    
    func execute(req: Request, input: Input) async throws -> Output {
        let hashedToken = SHA256.hash(input)
        
        guard let passwordToken = try await req.passwordTokens.find(token: hashedToken) else { throw AuthenticationError.invalidPasswordToken }
        
        guard passwordToken.expiresAt > .now else {
            try await req.passwordTokens.delete(id: passwordToken.requireID())
            throw AuthenticationError.passwordTokenHasExpired
        }
        
        return .noContent
    }
}
