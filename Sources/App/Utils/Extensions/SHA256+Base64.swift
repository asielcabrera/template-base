//
//  SHA256+Base64.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/10/24.
//

import Crypto
import struct Foundation.Data

extension SHA256Digest {
    var base64: String {
        Data(self).base64EncodedString()
    }
    
    var base64URLEncoded: String {
        Data(self).base64URLEncodedString()
    }
}
