//
//  UserAuthenticator.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/10/24.
//

import Vapor
import JWT

struct UserAuthenticator: AsyncJWTAuthenticator {
    typealias Payload = AuthPayload
    func authenticate(jwt: AuthPayload, for request: Request) async throws {
        request.auth.login(jwt)
    }
}
