//
//  CreatePasswordToken.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/10/24.
//

import Fluent

struct CreatePasswordToken: AsyncMigration {
    func prepare(on database: Database) async throws -> Void {
        try await database.schema("user_password_tokens")
            .id()
            .field("user_id", .uuid, .required, .references("users", "id", onDelete: .cascade))
            .field("token", .string, .required)
            .field("expires_at", .datetime, .required)
            .create()
    }
    
    func revert(on database: Database) async throws -> Void {
        try await database.schema("user_password_tokens").delete()
    }
}
