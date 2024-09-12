//
//  UserCreate.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/10/24.
//

import protocol Vapor.Content

extension User: Entity {
    struct Create: Content {
        let fullName: String
        let passwork: String
        let email: String
    }
}
