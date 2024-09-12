//
//  SHA256+String.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/10/24.
//

import Crypto
import Foundation

extension SHA256 {
    /// Returns hex-encoded string
    static func hash(_ string: String) -> String {
        SHA256.hash(data: string.data(using: .utf8)!)
    }
    
    /// Returns a hex encoded string
    static func hash<D>(data: D) -> String where D : DataProtocol {
        SHA256.hash(data: data).hex
    }
}
