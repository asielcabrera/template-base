//
//  PatientPublic.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/20/24.
//

import protocol Vapor.Content
import struct Foundation.Date
import struct Foundation.UUID

extension Patient {
    struct Public: Content {
        var id: UUID?
        var name: String
        var age: Int
        var gender: String
        var occupation: String
        var address: String
        var phone: String
        var email: String
        var createdAt: Date?
    }

    public func toPublic() -> Public {
        return .init(
            id: self.id, 
            name: self.name, 
            age: self.age, 
            gender: self.gender, 
            occupation: "", 
            address: self.address, 
            phone: "", 
            email: "", 
            createdAt: self.createdAt)
    }
}
