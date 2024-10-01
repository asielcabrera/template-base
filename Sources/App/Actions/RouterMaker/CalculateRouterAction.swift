//
//  CalculateRouterAction.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/20/24.
//
import Vapor

struct CalculateRouterAction: Action {

    func execute(req: Request, input: String) async throws -> CaculateRoute {
        print("Calculate")
        
        let kmean = KMeans(k: 4, maxIterations: 400)
        let patiens = try await Patient.query(on: req.db).all()
        let trips =  kmean.cluster(patients: patiens)
        
        return .init(trips: trips)
    }
}

struct CaculateRoute: Content, Sendable {
    let trips: [[Patient]]
}
