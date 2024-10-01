//
//  PasswordResetter.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/10/24.
//

import Vapor
import Queues

struct PasswordResetter {
    let queue: Queue
    let repository: PasswordTokenRepository
    let eventLoop: EventLoop
    let config: AppConfig
    let generator: RandomGenerator
    
    /// Sends a email to the user with a reset-password URL
    func reset(for user: User) async throws {
        do {
            let token = generator.generate(bits: 256)
            let resetPasswordToken = try PasswordToken(userID: user.requireID(), token: SHA256.hash(token))
            let url = resetURL(for: token)
            let email = ResetPasswordEmail(resetURL: url)
            
            _ = try await repository.create(resetPasswordToken)
            try await queue.dispatch(EmailJob.self, .init(email, to: user.email))
    
        } catch {
            throw error
        }
    }
    
    private func resetURL(for token: String) -> String {
        "\(config.frontendURL)/auth/reset-password?token=\(token)"
    }
}

extension Request {
    var passwordResetter: PasswordResetter {
        .init(queue: self.queue, repository: self.passwordTokens, eventLoop: self.eventLoop, config: self.application.config, generator: self.application.random)
    }
}
