import NIOSSL
import Fluent
import FluentPostgresDriver
import Vapor
import JWT
import QueuesRedisDriver
import Leaf
import Resend

// configures your application
public func configure(_ app: Application) async throws {
    
    // Middlewares
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.middleware.use(ErrorMiddleware.custom(environment: app.environment))
    
    // Database
    app.databases.use(DatabaseConfigurationFactory.postgres(configuration: .init(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? SQLPostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
        database: Environment.get("DATABASE_NAME") ?? "vapor_database",
        tls: .prefer(try .init(configuration: .clientDefault)))
    ), as: .psql)
    
    // TODO: - RESEND = re_PnB2CCPU_JonqirmcX5uzbVRNrPWojAQ6
    app.resend.initialize()
    app.views.use(.leaf)
    
    //    app.config = .environment
    
    // migrations
    app.migrations.add(CreateUser())
    app.migrations.add(CreateRefreshToken())
    app.migrations.add(CreateEmailToken())
    app.migrations.add(CreatePasswordToken())
    
    // MARK: Queues Configuration
        try app.queues.use(.redis(url: "redis://localhost:6379"))
    
    // MARK: Jobs
        app.queues.add(EmailJob())
    
    // MARK: Services
        app.randomGenerators.use(.random)

    // register routes
    try routes(app)
    
    
    if app.environment.isRelease {
        
    } else {
        app.jwt.signers.use(.hs256(key: "supersecretkey"))
        try await app.autoMigrate()
        try app.queues.startInProcessJobs(on: .default)
    }
    app.actions.use { app in
        CreateUserAction()
       
    }
    app.actions.use { app in
        LoginUserAction()
    }
}





