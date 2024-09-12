//
//  Payload.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/10/24.
//

import Vapor
import JWT

struct Payload: JWTPayload, Authenticatable, @unchecked Sendable {
    // User-releated stuff
    var userID: UUID
    var fullName: String
    var email: String
    var role: Role
    
    // JWT stuff
    var exp: ExpirationClaim
    
    func verify(using signer: JWTSigner) throws {
        try self.exp.verifyNotExpired()
    }
    
    init(with user: User) throws {
        self.userID = try user.requireID()
        self.fullName = user.fullName
        self.email = user.email
        self.role = user.role
        self.exp = ExpirationClaim(value: Date().addingTimeInterval(Constants.ACCESS_TOKEN_LIFETIME))
    }
}

extension User {
    convenience init(from payload: Payload) {
        self.init(id: payload.userID, fullName: payload.fullName, email: payload.email, passwordHash: "", role: payload.role)
    }
}
