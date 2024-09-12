//
//  Action.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/10/24.
//
import Vapor

protocol Action: Sendable {
    associatedtype Input: Sendable
    associatedtype Output: Sendable

    func execute(req: Request, input: Input) async throws -> Output
}
