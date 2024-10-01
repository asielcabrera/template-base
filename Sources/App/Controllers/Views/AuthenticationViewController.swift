//
//  AuthenticationViewController.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/10/24.
//

import Fluent
import Leaf
import Vapor

struct AuthenticationViewController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let authRoutes = routes.grouped(UserAuthenticator())

        routes.get("register", use: register)
        //        routes.post("register", use: registerPost)
        routes.get("login", use: login)
        routes.post("login", use: loginPost)
        authRoutes.get("dashboard", use: dashboard)

        // Rutas protegidas para manejar usuarios, pacientes y viajes
        authRoutes.get("manage-workers", use: manageWorker)
        authRoutes.get("edit-user", ":userID", use: editUser)
        authRoutes.post("edit-user", ":userID", use: updateUser)
        authRoutes.get("delete-user", ":userID", use: deleteUser)

        authRoutes.get("manage-patients", use: managePatients)
        authRoutes.get("manage-trips", use: manageTrips)
    }

    // MARK: - Register
    @Sendable
    func register(req: Request) async throws -> View {
        return try await req.view.render("register")
    }

    @Sendable
    func registerPost(req: Request) async throws -> Response {
        //        let userData = try req.content.decode(UserData.self)
        //        let user = User(fullName: userData.name, email: userData.email, passwordHash: try Bcrypt.hash(userData.password!))
        //        try await user.save(on: req.db)
        //        req.auth.login(user)
        return req.redirect(to: "/views/dashboard")
    }

    // MARK: - Login
    @Sendable
    func login(req: Request) async throws -> View {
        return try await req.view.render("login")
    }

    @Sendable
    func loginPost(req: Request) async throws -> Response {
        let loginData = try req.content.decode(LoginData.self)
        guard
            let user = try await User.query(on: req.db).filter(\.$email == loginData.email).first(),
            try Bcrypt.verify(loginData.password, created: user.passwordHash)
        else {
            return req.redirect(to: "/views/login")
        }
        //        req.auth.login(user)
        return req.redirect(to: "/views/dashboard")
    }

    // MARK: - Dashboard
    @Sendable
    func dashboard(req: Request) async throws -> View {
        guard let token = req.session.data["sessionToken"] else {
            throw Abort.redirect(to: "/views/login")
        }

        let userID = try req.jwt.verify(token, as: AuthPayload.self).userID
        let user = try await req.users.find(id: userID)

        return try await req.view.render("dashboard", ["user": user])
    }

    // MARK: - Manage Users
    @Sendable
    func manageWorker(req: Request) async throws -> View {
        guard let token = req.session.data["sessionToken"] else {
            throw Abort.redirect(to: "/views/login")
        }
        let userID = try req.jwt.verify(token, as: AuthPayload.self).userID
        guard let user = try await req.users.find(id: userID) else {
            throw Abort.redirect(to: "/views/login")
        }
        struct Context: Content {
            let user: User.Public
            let workers: [Workers]
        }

        struct Workers: Content {
            let name: String
            let email: String
            let position: String

            static var example: [Self] {
                [
                    .init(
                        name: "Elena Bretones", email: "elenabsuarez98@gmail.com", position: "CTO")
                ]
            }
        }
        let context = Context(user: user.toPublic(), workers: Workers.example)

        return try await req.view.render("Pages/Manage-Workers", ["context": context])
    }

    @Sendable
    func editUser(req: Request) async throws -> View {
        guard let userID = req.parameters.get("userID"), let uuid = UUID(userID),
            let user = try await User.find(uuid, on: req.db)
        else {
            throw Abort(.notFound)
        }
        return try await req.view.render("editUser", ["user": user])
    }

    @Sendable
    func updateUser(req: Request) async throws -> Response {
        let userData = try req.content.decode(UserData.self)
        guard let userID = req.parameters.get("userID"), let uuid = UUID(userID),
            let user = try await User.find(uuid, on: req.db)
        else {
            throw Abort(.notFound)
        }
        user.fullName = userData.name
        user.email = userData.email
        if let newPassword = userData.password, !newPassword.isEmpty {
            user.passwordHash = try Bcrypt.hash(newPassword)
        }
        try await user.save(on: req.db)
        return req.redirect(to: "/views/manage-users")
    }

    @Sendable
    func deleteUser(req: Request) async throws -> Response {
        guard let userID = req.parameters.get("userID"), let uuid = UUID(userID),
            let user = try await User.find(uuid, on: req.db)
        else {
            throw Abort(.notFound)
        }
        try await user.delete(on: req.db)
        return req.redirect(to: "/views/manage-users")
    }

    // MARK: - Manage Patients
    @Sendable
    func managePatients(req: Request) async throws -> View {
    guard let token = req.session.data["sessionToken"] else {
                throw Abort.redirect(to: "/views/login")
            }
            let userID = try req.jwt.verify(token, as: AuthPayload.self).userID
            guard let user = try await req.users.find(id: userID) else {
                throw Abort.redirect(to: "/views/login")
            }
        struct Context: Content {
            let user: User.Public
            let patients: [Patient.Public]
        }

        let patients = try await Patient.query(on: req.db).all().map { $0.toPublic() }
        let context = Context(user: user.toPublic(), patients: patients)

        return try await req.view.render("Pages/Manage-Patients", ["context": context])
    }

    // MARK: - Manage Trips
    @Sendable
    func manageTrips(req: Request) async throws -> View {
        let trips = [Trip]()
        //        let trips = try await Trip.query(on: req.db).all()
        return try await req.view.render("manageTrips", ["trips": trips])
    }
}

// MARK: - User Data
struct UserData: Content {
    let name: String
    let email: String
    let password: String?
}

// MARK: - Login Data
struct LoginData: Content {
    let email: String
    let password: String
}
