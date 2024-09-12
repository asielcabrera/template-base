//
//  UserRepository.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/10/24.
//

import Vapor
import struct Foundation.UUID
import protocol Fluent.Database
import Fluent

struct UserRepository: UserRepositoryProtocol {
   
    var database: Database
    
    func findAll() async throws -> [User] {
        try await User.query(on: database).all()
    }
    
    func find(id: UUID) async throws -> User? {
        try await User.find(id, on: database)
    }
    
    func find(email: String) async throws -> User? {
        return try await User.query(on: database).filter(\.$email, .equal, email).first()
    }
    
    func create(_ model: User) async throws -> User {
        try await model.save(on: database)
        
        return model
    }
    
    func update(_ model: User.Public) async throws {
        let user = try await User.find(model.id, on: database)
        user?.$email.value = model.email
        user?.$fullName.value = model.fullName
        user?.$role.value = model.role
        
        try await user?.update(on: database)
    }
    
    func delete(id: UUID) async throws {
        guard let user = try await User.find(id, on: database) else {
            throw Abort(.notFound)
        }
        try await user.delete(on: database)
    }
    
    func set<Field>(_ field: KeyPath<User, Field>, to value: Field.Value, for userID: UUID) async throws where Field : QueryableProperty, User == Field.Model {
        
    }
    
    func count() async throws -> Int {
        0
    }
}
