//
//  CalculateDistanceAction.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/20/24.
//
import Vapor

struct CalculateDistanceAction: Action {
   
    func execute(req: Request, input: CalculateDistanceData) async throws -> Double {
        let diffX = input.pointX.latitude - input.pointY.latitude
        let diffY = input.pointX.longitude - input.pointY.longitude
        
        return sqrt(diffX * diffX + diffY * diffY)
    }
}
