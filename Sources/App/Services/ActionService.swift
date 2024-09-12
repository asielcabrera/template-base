//
//  ActionService.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/10/24.
//
import Vapor

struct ActionService {
    func execute<A: Action>(_ req: Request, _ action: A, input: A.Input) async throws -> A.Output {
        return try await action.execute(req: req, input: input)
    }
}

extension Application {
    var actionService: ActionService {
        return .init()
    }
}
