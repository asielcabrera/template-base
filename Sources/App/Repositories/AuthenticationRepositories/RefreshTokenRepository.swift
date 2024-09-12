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
        
    }
    
    func count() async throws -> Int {
        0
    }
    
    var database: any Database
    
    func findAll() async throws -> [RefreshToken] {
        []
    }
    
    func find(id: UUID) async throws -> RefreshToken? {
        nil
    }
    
    func find(token: String) async throws -> RefreshToken? {
        nil
    }
    
    func create(_ model: RefreshToken) async throws -> RefreshToken {
        RefreshToken()
    }
    
    func update(_ model: RefreshToken.Public) async throws {
        
    }
    
    func delete(id: UUID) async throws {
    
    }
}
