//
//  RefreshTokenRepository.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/10/24.
//

import protocol Fluent.Database
import struct Foundation.UUID
import Fluent

struct RefreshTokenRepository: RefreshTokenRepositoryProtocol {
    func set<Field>(_ field: KeyPath<RefreshToken, Field>, to value: Field.Value, for userID: UUID) async throws where Field : QueryableProperty, RefreshToken == Field.Model {
        try await RefreshToken.query(on: database)
            .filter(\.$id == userID)
            .set(field, to: value)
            .update()
    }
    
    func count() async throws -> Int {
        try await RefreshToken.query(on: self.database).count()
    }
    
    var database: any Database
    
    func findAll() async throws -> [RefreshToken] {
        try await RefreshToken.query(on: self.database).all()
    }
    
    func find(id: UUID) async throws -> RefreshToken? {
        try await RefreshToken.find(id, on: self.database)
    }
    
    func find(token: String) async throws -> RefreshToken? {
        try await RefreshToken.query(on: self.database).filter(\.$token == token).first()
    }
    
    func create(_ model: RefreshToken) async throws {
        try await model.create(on: self.database)
    }
    
    func update(_ model: RefreshToken.Public) async throws {
    
    }
    
    func delete(id: UUID) async throws {
        try await RefreshToken.query(on: self.database).filter(\.$user.$id == id).delete()
    }
}
