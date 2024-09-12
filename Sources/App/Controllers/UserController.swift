//
//  UserController.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/10/24.
//
import Vapor

struct UserController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        routes.group("auth") { auth in
            auth.post("register", use: register)
            auth.post("login", use: login)
            
            auth.group("reset-password") { resetPasswordRoutes in
//                resetPasswordRoutes.post("", use: resetPassword)
//                resetPasswordRoutes.get("verify", use: verifyResetPasswordToken)
//            }
//            auth.post("recover", use: recoverAccount)
//            
            auth.post("accessToken", use: refreshAccessToken)
            
                // Authentication required
                auth.group(UserAuthenticator()) { authenticated in
                    authenticated.get("me", use: getCurrentUser)
                }
            }
        }
    }

    @Sendable
    private func register(_ req: Request) async throws -> HTTPStatus {
        try Register.Request.validate(content: req)
        let input = try req.content.decode(CreateUserAction.Input.self)
        let createUserAction = req.application.actions.make(CreateUserAction.self)
        _ = try await req.application.actionService.execute(req, createUserAction, input: input)

        return .created
    }
    
    @Sendable
    private func login(_ req: Request) async throws -> Login.Response {
        try Login.Request.validate(content: req)
        let input = try req.content.decode(Login.Request.self)
        let loginUserAction = req.application.actions.make(LoginUserAction.self)
        let output = try await req.application.actionService.execute(req, loginUserAction, input: input)
        
        return output
    }
    
    @Sendable
    private func refreshAccessToken(_ req: Request) async throws -> AccessToken.Response {
        let input = try req.content.decode(AccessToken.Request.self)
        let refreshTokens = req.application.actions.make(RefreshAccessTokenAction.self)
        let output = try await req.application.actionService.execute(req, refreshTokens, input: input)
        return  output
    }
    
    @Sendable
    private func getCurrentUser(_ req: Request) async throws -> User.Public {
        let input = try req.auth.require(Payload.self)
        let getCurrentUser = req.application.actions.make(GetCurrentUserAction.self)
        let output = try await req.application.actionService.execute(req, getCurrentUser, input: input)
        return  output
        
    }
    
    @Sendable
    private func verifyEmail(_ req: Request) async throws -> HTTPStatus {
        let input = try req.query.get(String.self, at: "token")
        let verifyEmail = req.application.actions.make(VerifyEmailAction.self)
        let output = try await req.application.actionService.execute(req, verifyEmail, input: input)
        return  output
    }
    
    @Sendable
    private func resetPassword(_ req: Request) async throws -> HTTPStatus {
        let input =  try req.content.decode(Recovery.ResetPasswordRequest.self)
        let resetPassword = req.application.actions.make(ResetPasswordAction.self)
        let output = try await req.application.actionService.execute(req, resetPassword, input: input)
        return  output
    }
    
    @Sendable
    private func verifyResetPasswordToken(_ req: Request) async throws -> HTTPStatus {
        let input = try req.query.get(String.self, at: "token")
        let verifyResetPasswordToken = req.application.actions.make(VerifyResetPasswordTokenAction.self)
        let output = try await req.application.actionService.execute(req, verifyResetPasswordToken, input: input)
        return  output
    }
    
    @Sendable
    private func recoverAccount(_ req: Request) async throws -> HTTPStatus {
        try Recovery.AccountRequest.validate(content: req)
        let input = try req.content.decode(Recovery.AccountRequest.self)
        let recoverAccount = req.application.actions.make(RecoverAccountAction.self)
        let output = try await req.application.actionService.execute(req, recoverAccount, input: input)
        return  output
        
    }
    
    @Sendable
    private func sendEmailVerification(_ req: Request) async throws -> HTTPStatus {
        let input = try req.content.decode(SendEmailVerification.Request.self)
        let sendEmailVerification = req.application.actions.make(SendEmailVerificationAction.self)
        let output = try await req.application.actionService.execute(req, sendEmailVerification, input: input)
        return  output
    }
}
