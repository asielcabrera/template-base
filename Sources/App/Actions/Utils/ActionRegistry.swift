//
//  ActionRegistry.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/10/24.
//
import Vapor
import NIOConcurrencyHelpers


extension Request {
    var actions: Application.ActionRegistry {
        self.application.actions
    }
}

extension Application {
    var actions: ActionRegistry {
        .init(app: self)
    }
    
    struct ActionRegistry {
        
        public let app: Application
        
        struct Provider: Sendable {
            let run: @Sendable (Application) -> ()
            
            @preconcurrency public init(run: @Sendable @escaping (Application) -> Void) {
                self.run = run
            }
        }
        subscript<A: Action> (_ action: A) -> any Action {
            app.storage[ActionKey<A>.self]!
        }
        final class Storage: Sendable {
            struct ActionRegistryFactory {
                let factory: (@Sendable (Application) -> any Action)?
            }
            
            let makeAction: NIOLockedValueBox<ActionRegistryFactory>
            
            init() {
                self.makeAction = .init(.init(factory: nil))
            }
        }
        
        var storage: Storage {
            guard let storage = self.app.storage[Key.self] else {
                fatalError("Action registry not configured. Configure with app.actions.initialize()")
            }
            return storage
        }
        
        struct Key: StorageKey {
            typealias Value = Storage
        }
        
        public func use(_ provider: Provider) {
            provider.run(app)
        }
        
        @preconcurrency public func use(_ makeAction: @Sendable @escaping (Application) -> (any Action)) {
            self.storage.makeAction.withLockedValue { $0 = .init(factory: makeAction)
            }
        }
        
        func use<A: Action>(_ make: @escaping (Application) -> A) {
            app.storage[ActionKey<A>.self] = make(app)
        }

        public func use<A: Action>(_ action: A) {
            app.storage[ActionKey<A>.self] = action
        }
        
        func make<A: Action>(_ type: A.Type = A.self) -> A {
            guard let action = app.storage[ActionKey<A>.self] else {
                fatalError("Action \(A.self) not Found")
            }
            
            return action
        }
        
        func initialize() {
            app.storage[Key.self] = .init()
        }
    }
    
    struct ActionKey<A: Action>: StorageKey {
        typealias Value = A
    }
}
