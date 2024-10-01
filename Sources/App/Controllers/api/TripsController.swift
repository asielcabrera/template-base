//
//  TripsController.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/20/24.
//

import Vapor

struct TripsController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.group("trips") { trips in
            trips.group("calculate") { calculate in
                calculate.group(UserAuthenticator()) { authenticated in
                    print("Resolved - test")
                    authenticated.get("resolved", use: resolved) 
                }
            }
        }
    }
    
    @Sendable
    private func resolved(_ req: Request) async throws -> CaculateRoute {
        try req.auth.require(AuthPayload.self)
        let input = ""
        let output = try await req.actions.calculateRouterAction.execute(req: req, input: input)
        return output
    }
}
