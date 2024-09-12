//
//  LoginUserAction.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/11/24.
//

import Vapor
import Fluent

struct LoginUserAction: Action {
    typealias Input = Login.Request
    typealias Output = Login.Response
    
    func execute(req: Request, input: Input) async throws -> Output {
        guard let user = try await req.users.find(email: input.email) else { throw AuthenticationError.invalidEmailOrPassword }
//        guard user.isEmailVerified else { throw AuthenticationError.emailIsNotVerified }
        
        let passwordMatches = try await req.password.async.verify(input.password, created: user.passwordHash)
        guard passwordMatches else { throw AuthenticationError.invalidEmailOrPassword }
        
        try await req.refreshTokens.delete(id: user.requireID())
        
        let token = req.random.generate(bits: 256)
        let refreshToken = try RefreshToken(token: SHA256.hash(token), userID: user.requireID())
        
        _ = try await req.refreshTokens.create(refreshToken)
        
        let accessToken = try req.jwt.sign(Payload(with: user))
        
        return Login.Response(user: user.toPublic(), accessToken: accessToken, refreshToken: token)
    }
}

