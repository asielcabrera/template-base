//
//  ActionRegistry.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/10/24.
//
import Vapor

extension Application {
    var actions: ActionRegistry {
        .init(app: self)
    }
    
    struct ActionRegistry {
        let app: Application
        
        func use<A: Action>(_ make: @escaping (Application) -> A) {
            app.storage[ActionKey<A>.self] = make(app)
        }
        
        func make<A: Action>(_ type: A.Type = A.self) -> A {
            guard let action = app.storage[ActionKey<A>.self] else {
                fatalError("Action \(A.self) not Found")
            }
            
            return action
        }
    }
    
    struct ActionKey<A: Action>: StorageKey {
        typealias Value = A
    }
}
