//
//  Request+Services.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/10/24.
//

import Vapor

extension Request {
    // MARK: Repositories
    var users: UserRepository { UserRepository(database: self.db) }
    
    var refreshTokens: RefreshTokenRepository { RefreshTokenRepository(database: self.db) }
    var emailTokens: EmailTokenRepository { EmailTokenRepository(database: self.db) }
    var passwordTokens: PasswordTokenRepository { PasswordTokenRepository(database: self.db) }
    
//    var refreshTokens: RefreshTokenRepository { application.repositories.refreshTokens.for(self) }
//    var emailTokens: EmailTokenRepository { application.repositories.emailTokens.for(self) }
//    var passwordTokens: PasswordTokenRepository { application.repositories.passwordTokens.for(self) }
//    
    
//    var orders: OrderRepository { application.repositories.orders.for(self) }
    
//    var email: EmailVerifier { application.emailVerifiers.verifier.for(self) }
}
