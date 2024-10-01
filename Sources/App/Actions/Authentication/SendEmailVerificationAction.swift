//
//  SendEmailVerificationAction.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/12/24.
//

import Vapor
import Fluent

struct SendEmailVerificationAction: Action {

    func execute(req: Request, input: SendEmailVerification.Request) async throws -> HTTPStatus {
        guard let user = try await req.users.find(email: input.email) else { throw AuthenticationError.userNotFound }
        
        if user.isEmailVerified {
            return .notFound
        }
        
        try await req.emailVerifier.verify(for: user)
        return .noContent
        
    }
}
