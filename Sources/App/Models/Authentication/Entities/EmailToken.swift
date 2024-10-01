//
//  EmailToken.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/10/24.
//

import Fluent
import struct Foundation.UUID
import struct Foundation.Date
import protocol Vapor.Content

final class EmailToken: Model, @unchecked Sendable {
    static let schema = "user_email_tokens"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "user_id")
    var user: User
    
    @Field(key: "token")
    var token: String
    
    @Field(key: "expires_at")
    var expiresAt: Date
    
    init() {}
    
    init(
        id: UUID? = nil,
        userID: UUID,
        token: String,
        expiresAt: Date = Date().addingTimeInterval(Constants.EMAIL_TOKEN_LIFETIME)
    ) {
        self.id = id
        self.$user.id = userID
        self.token = token
        self.expiresAt = expiresAt
    }
}


extension EmailToken: Entity {
    struct Public: Content {
        let id: UUID?
        let user: User.Public
        let token: String
        let expiresAt: Date
    }
}
