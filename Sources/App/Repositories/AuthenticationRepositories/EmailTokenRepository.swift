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
 
    func count() async throws -> Int {
        0
    }
    
    var database: Database
    
    func findAll() async throws -> [EmailToken] {
            []
    }
    
    func find(id: UUID) async throws -> EmailToken? {
            nil
    }
    
    func find(token: String) async throws -> EmailToken? {
        nil
    }
    
    func create(_ model: EmailToken) async throws -> EmailToken {
        EmailToken()
    }
    
    func update(_ model: EmailToken.Public) async throws {
            
    }
    
    func set<Field>(_ field: KeyPath<EmailToken, Field>, to value: Field.Value, for userID: UUID) async throws where Field : QueryableProperty, EmailToken == Field.Model {
        
    }
    
    func delete(id: UUID) async throws {
            
    }
}
