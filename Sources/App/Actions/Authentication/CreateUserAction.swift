//
//  CreateUserAction.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/11/24.
//

import Vapor
import Fluent

struct CreateUserAction: Action {
    
    typealias Input = Register.Request
    
    typealias Output = HTTPStatus
    
    func execute(req: Request, input: Input) async throws -> Output {
        
        guard input.password == input.confirmPassword else {
            throw AuthenticationError.passwordsDontMatch
        }
        
        let passHash = try req.password.hash(input.password)
        let user = try User(from: input, hash: passHash)
        
        do {
            _ = try await req.users.create(user)
            
            // TODO: define emailVerifier
            //            try await req.emailVerifier.veirify(for: user)
            return .created
        }
        
        catch let error as DatabaseError where error.isConstraintFailure {
            throw AuthenticationError.emailAlreadyExists
        } catch {
            throw error
        }
        
    }
}
