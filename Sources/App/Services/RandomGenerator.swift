//
//  RandomGenerator.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/10/24.
//

import Vapor
import Crypto

public protocol RandomGenerator: Sendable {
    func generate(bits: Int) -> String
}

extension Application {
    public final class RandomGenerators: Sendable {
        public struct Provider {
            let run: ((Application) -> Void)
        }
        
        public let app: Application
        
        init(app: Application) {
            self.app = app
        }
        
        public func use(_ provider: Provider) {
            provider.run(app)
        }
        
        public func use(_ makeGenerator: @escaping ((Application) -> RandomGenerator)) {
            storage.makeGenerator = makeGenerator
        }
        
        final class Storage: @unchecked Sendable {
            var makeGenerator: ((Application) -> RandomGenerator)?
            init() {}
        }
        
        private struct Key: StorageKey {
            typealias Value = Storage
        }
        
        var storage: Storage {
            if let existing = self.app.storage[Key.self] {
                return existing
            } else {
                let new = Storage()
                self.app.storage[Key.self] = new
                return new
            }
        }
    }
    
    public var randomGenerators: RandomGenerators {
        .init(app: self)
    }
}

extension Request {
    var random: RandomGenerator {
        self.application.random
    }
}
