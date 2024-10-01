//
//  EmailTokenRepository.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/10/24.
//

import struct Foundation.UUID
import protocol Fluent.Database
import Fluent

struct EmailTokenRepository: EmailTokenRepositoryProtocol {
   var database: Database
    
    func count() async throws -> Int {
        try await EmailToken.query(on: self.database).count()
    }

    func findAll() async throws -> [EmailToken] {
        try await EmailToken.query(on: self.database).all()
    }
    
    func find(id: UUID) async throws -> EmailToken? {
        try await EmailToken.find(id, on: self.database)
    }
    
    func find(token: String) async throws -> EmailToken? {
       try await EmailToken.query(on: self.database).filter(\.$token == token).first()
    }
    
    func create(_ model: EmailToken) async throws -> Void {
        try await model.save(on: self.database)
    }
    
    func update(_ model: EmailToken.Public) async throws {
        let emailToken = try await EmailToken.find(model.id, on: self.database)
        emailToken?.token = model.token
        emailToken?.expiresAt = model.expiresAt
        emailToken?.$user.id = model.user.id!
        
        try await emailToken?.update(on: self.database)
    }
    
    func set<Field>(_ field: KeyPath<EmailToken, Field>, to value: Field.Value, for userID: UUID) async throws where Field : QueryableProperty, EmailToken == Field.Model {
        
    }
    
    func delete(id: UUID) async throws {
        let emailToken = try await EmailToken.find(id, on: self.database)
        try await emailToken?.delete(on: self.database)
    }
}
