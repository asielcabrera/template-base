//
//  PatientController.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/20/24.
//

import Vapor
import Fluent

struct PatientController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.group("patients") { patients in
            print("router patient")
            
            let auth = patients.grouped(UserAuthenticator())

            auth.get("", use: getAllPatient)
            auth.post("create", use: createPatient) 
        }
    }
    
    @Sendable
    private func getAllPatient(_ req: Request) async throws -> [Patient.Public] {
        print("llamando")
        // try req.auth.require(AuthPayload.self)
        return try await Patient.query(on: req.db).all().map { $0.toPublic() }
    }

    @Sendable
    private func createPatient(_ req: Request) async throws -> HTTPStatus {
        print("request")
        
        try req.auth.require(AuthPayload.self)  
        print(req.content)
        let input = try req.content.decode(Patient.Create.self)
        print(input)
        try await Patient(input).create(on: req.db)
        return .ok
    }
}
