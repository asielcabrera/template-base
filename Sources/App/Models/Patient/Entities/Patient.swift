//
//  Patient.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/20/24.
//

import Fluent
import CoreLocation
import struct Foundation.UUID
import struct Foundation.Date

final class Patient: Model, @unchecked Sendable {
    static let schema = "patients"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "age")
    var age: Int
    
    @Field(key: "gender")
    var gender: String
    
    @Timestamp(key: "createdAt", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updatedAt", on: .update)
    var updatedAt: Date?
    
    @Field(key: "address")
    var address: String
    
    var coordinates: CLLocationCoordinate2D {
        let logitude: Double = 0.0
        let latitude: Double = 0.0
        return CLLocationCoordinate2D(latitude: latitude, longitude: logitude)
    }
    
    required init() { }
    
    init(id: UUID? = nil,
         name: String,
         age: Int,
         gender: String,
         createdAt: Date? = nil,
         updatedAt: Date? = nil,
         address: String) {
        self.id = id
        self.name = name
        self.age = age
        self.gender = gender
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.address = address
    }
}
