//
//  ResetPasswordAction.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/12/24.
//

import Vapor
import Fluent

struct ResetPasswordAction: Action {

    func execute(req: Request, input: Recovery.ResetPasswordRequest) async throws -> HTTPStatus {
        guard let user = try await req.users.find(email: input.email) else {
            return .noContent
        }
        
        try await req.passwordResetter.reset(for: user)
        
        return .ok
    }
}
