//
//  RealRandomGenerator.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/10/24.
//

import Vapor

extension Application.RandomGenerators.Provider {
    static var random: Self {
        .init {
            $0.randomGenerators.use { _ in RealRandomGenerator() }
        }
    }
}

struct RealRandomGenerator: RandomGenerator {
    func generate(bits: Int) -> String {
        [UInt8].random(count: bits / 8).hex
    }
}
