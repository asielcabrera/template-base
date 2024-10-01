//
//  CreateUserAction.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/11/24.
//

import Vapor
import Fluent

struct CreateUserAction: Action {
    
    func execute(req: Request, input: Register.Request) async throws -> HTTPStatus {
        
        guard input.password == input.confirmPassword else {
            throw AuthenticationError.passwordsDontMatch
        }
        
        let passHash = try req.password.hash(input.password)
        let user = try User(from: input, hash: passHash)
        
        do {
            try await req.users.create(user)
            
            try await req.emailVerifier.verify(for: user)
            return .created
        }
        
        catch let error as DatabaseError where error.isConstraintFailure {
            throw AuthenticationError.emailAlreadyExists
        } catch {
            throw error
        }
        
    }
}



