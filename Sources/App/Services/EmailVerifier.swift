//
//  EmailVerifier.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/10/24.
//

import Vapor
import Queues

struct EmailVerifier {
    
    let emailTokenRepository: EmailTokenRepository
//    let config: AppConfig
    let queue: Queue
    let eventLoop: EventLoop
    let generator: RandomGenerator
    
    func verify(for user: User) async throws {
        do {
            let token = generator.generate(bits: 256)
            let emailToken = try EmailToken(userID: user.requireID(), token: SHA256.hash(token))
            let verifyUrl = url(token: token)
            
            _ = try await emailTokenRepository.create(emailToken)
            
            var verificationEmail = VerificationEmail(verifyUrl: verifyUrl)
            verificationEmail.append(key: "username", value: user.fullName)
            verificationEmail.append(key: "platform", value: "stpp")
            verificationEmail.append(key: "link", value: verifyUrl)
            
            try await queue.dispatch(EmailJob.self, .init(verificationEmail, to: user.email))
        } catch {
            print(error)
            throw error
        }
    }
    
    private func url(token: String) -> String {
//        #"\#(config.apiURL)/auth/email-verification?token=\#(token)"#
        #"https://localhost:8080/auth/email-verification?token=\#(token)"#
    }
}


extension Request {
    var emailVerifier: EmailVerifier {
        .init(emailTokenRepository: self.emailTokens, queue: self.queue, eventLoop: eventLoop, generator: self.application.random)
    }
}
