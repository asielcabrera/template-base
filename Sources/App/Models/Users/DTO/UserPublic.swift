//
//  Public.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/10/24.
//
import Vapor
import struct Foundation.UUID

extension User {
    struct Public: Content {
        var id: UUID?
        let fullName: String?
        let email: String?
        let role: Role?
    }
}
