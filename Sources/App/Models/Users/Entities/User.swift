//
//  User.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/10/24.
//
import Vapor
import Fluent
import struct Foundation.UUID

final class User: Model, @unchecked Sendable {
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "full_name")
    var fullName: String
    
    @Field(key: "email")
    var email: String
    
    @Field(key: "password_hash")
    var passwordHash: String
    
    @Field(key: "role")
    var role: Role
    
    @Field(key: "is_email_verified")
    var isEmailVerified: Bool
    
    required init() {}
    
    init(
        id: UUID? = nil,
        fullName: String,
        email: String,
        passwordHash: String,
        role: Role = .customer,
        isEmailVerified: Bool = false
    ) {
        self.id = id
        self.fullName = fullName
        self.email = email
        self.passwordHash = passwordHash
        self.role = role
        self.isEmailVerified = isEmailVerified
    }
    
    func toPublic() -> User.Public {
        .init(
            id: self.id,
            fullName: self.$fullName.value,
            email: self.$email.value,
            role: self.$role.value
        )
    }
}
