//
//  GetCurrentUserAction.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/12/24.
//

import Vapor
import Fluent

struct GetCurrentUserAction: Action {
    
    func execute(req: Request, input: AuthPayload) async throws -> User.Public {

        guard let user = try await req.users.find(id: input.userID) else {
            throw AuthenticationError.userNotFound
        }
        return user.toPublic()
    }
}
