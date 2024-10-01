//
//  CreatePatient.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/20/24.
//

import Fluent

struct CreatePatient: AsyncMigration {
    func prepare(on database: Database) async throws  {
        try await database.schema("patients")
            .id()
            .field("name", .string, .required)
            .field("age", .int, .required)
            .field("gender", .string, .required)
            .field("createdAt", .datetime)
            .field("updatedAt", .datetime)
            .field("address", .string, .required)
            .create()
        
        
        // Insertar datos de prueba manualmente
        let patients = generateTestPatients()
        return try await patients.create(on: database)
        
    }
    
    func revert(on database: Database) async throws {
        return try await database.schema("patients").delete()
    }
    
    // Función para generar pacientes de prueba usando Faker
    private func generateTestPatients() -> [Patient] {
        return [
            Patient(name: "Ana López", age: 34, gender: "F", address: "Calle 1"),
            Patient(name: "Luis Martínez", age: 45, gender: "M", address: "Avenida 2"),
            Patient(name: "Carlos García", age: 29, gender: "M", address: "Calle 3"),
            Patient(name: "María Rodríguez", age: 52, gender: "F", address: "Boulevard 4"),
            Patient(name: "José Hernández", age: 39, gender: "M", address: "Carrera 5"),
            Patient(name: "Laura Fernández", age: 27, gender: "F", address: "Calle 6"),
            Patient(name: "Pedro Pérez", age: 63, gender: "M", address: "Avenida 7"),
            Patient(name: "Sofía Sánchez", age: 49, gender: "F", address: "Calle 8"),
            Patient(name: "Miguel Ramírez", age: 55, gender: "M", address: "Boulevard 9"),
            Patient(name: "Lucía Torres", age: 31, gender: "F", address: "Carrera 10"),
            // Añadir más pacientes según sea necesario
        ]
    }
}
