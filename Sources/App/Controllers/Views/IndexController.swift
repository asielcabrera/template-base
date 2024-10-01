
//
//  IndexController.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/26/24.
//

import Vapor

struct IndexController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.get(use: renderIndex)
    }
    
    @Sendable
    func renderIndex(req: Request) async throws -> View {
        let context = ["title": "Bienvenido"]
        print("index")
        return try await req.view.render("index", context)
    }
}
