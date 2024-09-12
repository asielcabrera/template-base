//
//  PasswordTokenRepository.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/10/24.
//

import struct Foundation.UUID
import protocol Fluent.Database
import Fluent

struct PasswordTokenRepository: PasswordTokenRepositoryProtocol {

    var database: Database
    
    func findAll() async throws -> [PasswordToken] {
        []
    }
    
    func find(id: UUID) async throws -> PasswordToken? {
        nil
    }
    
    func find(token: String) async throws -> PasswordToken? {
        nil
    }
    
    func create(_ model: PasswordToken) async throws -> PasswordToken {
        PasswordToken()
    }
    
    func update(_ model: PasswordToken.Public) async throws {
        
    }
    
    func delete(id: UUID) async throws {
            
    }
    
    func set<Field>(_ field: KeyPath<PasswordToken, Field>, to value: Field.Value, for userID: UUID) async throws where Field : FluentKit.QueryableProperty, PasswordToken == Field.Model {
        
    }
    
    func count() async throws -> Int {
        0
    }
}
