//
//  RefreshAccessTokenAction.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/11/24.
//

import Vapor
import Fluent

struct RefreshAccessTokenAction: Action {
    
    func execute(req: Request, input: AccessToken.Request) async throws -> AccessToken.Response {
        
        let hashedRefreshToken = SHA256.hash(input.refreshToken)
        
        guard let refreshToken = try await req.refreshTokens.find(token: hashedRefreshToken) else { throw AuthenticationError.refreshTokenOrUserNotFound }
        
        guard refreshToken.expiresAt > Date() else { throw AuthenticationError.refreshTokenHasExpired }
        
        guard let user = try await req.users.find(id: refreshToken.user.requireID()) else {
            throw AuthenticationError.refreshTokenOrUserNotFound
        }
        
        
        let token = req.random.generate(bits: 256)
        let hashedToken = SHA256.hash  (token)
        
        let newRefreshToken = try RefreshToken(token: hashedToken, userID: user.requireID())
        let payload = try AuthPayload(with: user)
        let accessToken = try req.jwt.sign(payload)
        
        
        _ = try await req.refreshTokens.create(newRefreshToken)
        
        return AccessToken.Response(refreshToken: token, accessToken: accessToken)
        
    }
}
