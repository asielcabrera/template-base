//
//  AccessToken.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/10/24.
//

import Vapor

struct AccessToken {
    struct Request: Content {
        let refreshToken: String
    }
    
    struct Response: Content {
        let refreshToken: String
        let accessToken: String
    }
}
