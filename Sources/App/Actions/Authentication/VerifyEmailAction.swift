//
//  VerifyEmailAction.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/12/24.
//

import Vapor
import Fluent

struct VerifyEmailAction: Action {

    func execute(req: Request, input: String) async throws -> HTTPStatus {
        let hashedToken = SHA256.hash(input)
        
        guard let emailToken = try await req.emailTokens.find(token: hashedToken) else { throw AuthenticationError.emailTokenNotFound }
        
        guard emailToken.expiresAt > .now else { throw AuthenticationError.emailTokenHasExpired }
        
        try await req.emailTokens.delete(id: emailToken.requireID())
        try await req.users.set(\.$isEmailVerified, to: true, for: emailToken.$user.id)
        
        return .ok
    }
}
