//
//  ResetPasswordAction.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/12/24.
//

import Vapor
import Fluent

struct ResetPasswordAction: Action {
    typealias Input = Recovery.ResetPasswordRequest
    typealias Output = HTTPStatus
    
    func execute(req: Request, input: Input) async throws -> Output {
        guard let _ = try await req.users.find(email: input.email) else {
            return .noContent
        }
        
//        try await req.passwordResetter.reset(for: user)
        
        return .ok
    }
}
