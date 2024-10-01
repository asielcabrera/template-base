//
//  LoginUserAction.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/11/24.
//

import Vapor
import Fluent

struct LoginUserAction: Action {
    
    func execute(req: Request, input: Login.Request) async throws -> Login.Response {
        guard let user = try await req.users.find(email: input.email) else { throw AuthenticationError.invalidEmailOrPassword }
        guard user.isEmailVerified else { throw AuthenticationError.emailIsNotVerified }
        
        let passwordMatches = try await req.password.async.verify(input.password, created: user.passwordHash)
        guard passwordMatches else { throw AuthenticationError.invalidEmailOrPassword }
        
        try await req.refreshTokens.delete(id: user.requireID())
        
        let token = req.random.generate(bits: 256)
        let refreshToken = try RefreshToken(token: SHA256.hash(token), userID: user.requireID())
        
        try await req.refreshTokens.create(refreshToken)
        
        let accessToken = try req.jwt.sign(AuthPayload(with: user))
        // Store the token in the session
        req.session.data["sessionToken"] = accessToken
        
        return Login.Response(user: user.toPublic(), accessToken: accessToken, refreshToken: token)
    }
}

