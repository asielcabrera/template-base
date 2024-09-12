//
//  RepositoryProtocol.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/10/24.
//
import struct Foundation.UUID
import protocol Vapor.Content
import protocol Fluent.Database
import Fluent

protocol Repository {
    
    associatedtype Element: Entity
    
    var database: Database { get }
    
    func findAll() async throws -> [Element]
    func find(id: UUID) async throws -> Element?
    func create(_ model: Element) async throws -> Element
    func update(_ model: Element.Public) async throws
    func delete(id: UUID) async throws
    
    func set<Field>(_ field: KeyPath<Element, Field>, to value: Field.Value, for userID: UUID) async throws  where Field: QueryableProperty, Field.Model == Element
    func count() async throws -> Int
}
 

protocol Entity {
    associatedtype Public
}
