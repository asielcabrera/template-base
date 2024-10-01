import NIOSSL
import Fluent
import FluentPostgresDriver
import Leaf
import Vapor
import JWT
import QueuesRedisDriver
import Resend

// configures your application
public func configure(_ app: Application) async throws {
    
    // Middlewares
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.middleware.use(ErrorMiddleware.custom(environment: app.environment))
    
    app.middleware.use(app.sessions.middleware)
    
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
    app.migrations.add(CreatePatient())
    
    // MARK: Queues Configuration
    try app.queues.use(.redis(url: "redis://localhost:6379"))
    
    // MARK: Jobs
    app.queues.add(EmailJob())
    app.queues.schedule(TripMakerJob()).everySecond()
    
    // MARK: Services
    app.randomGenerators.use(.random)
    
    // register routes
    try routes(app)
    app.commands.use(ListRoutesCommand(), as: "list-routes")
    
    if app.environment.isRelease {
        
    } else {
        app.jwt.signers.use(.hs256(key: "supersecretkey"))
        try await app.autoMigrate()
        try app.queues.startInProcessJobs(on: .default)
    }
    
    app.actions.initialize()
    app.actions.use(.createUserAction)
    app.actions.use(.loginAction)
    app.actions.use(.getCurrentUserAction)
    app.actions.use(CalculateRouterAction())
}

extension Application.ActionRegistry.Provider {
    public static var loginAction: Self {
        .init {
            $0.actions.use {
                $0.actions.loginUserAction
            }
        }
    }
}

extension Application.ActionRegistry.Provider {
    public static var createUserAction: Self {
        .init {
            $0.actions.use {
                $0.actions.createUserAction
            }
        }
    }
}

extension Application.ActionRegistry.Provider {
    public static var getCurrentUserAction: Self {
        .init {
            $0.actions.use {
                $0.actions.getCurrentUserAction
            }
        }
    }
}

extension Application.ActionRegistry.Provider {
    public static var refreshAccessTokenAction: Self {
        .init {
            $0.actions.use {
                $0.actions.refreshAccessTokenAction
            }
        }
    }
}

extension Application.ActionRegistry.Provider {
    public static var verifyEmailAction: Self {
        .init {
            $0.actions.use {
                $0.actions.verifyEmailAction
            }
        }
    }
}

extension Application.ActionRegistry.Provider {
    public static var resetPasswordAction: Self {
        .init {
            $0.actions.use {
                $0.actions.resetPasswordAction
            }
        }
    }
}



extension Application.ActionRegistry {
    public var resetPasswordAction: ResetPasswordAction {
        ResetPasswordAction()
    }
}


extension Application.ActionRegistry {
    public var loginUserAction: LoginUserAction {
        LoginUserAction()
    }
}


extension Application.ActionRegistry {
    public var createUserAction: CreateUserAction {
        CreateUserAction()
    }
}

extension Application.ActionRegistry {
    public var getCurrentUserAction: GetCurrentUserAction {
        GetCurrentUserAction()
    }
}

extension Application.ActionRegistry {
    public var refreshAccessTokenAction: RefreshAccessTokenAction {
        RefreshAccessTokenAction()
    }
}

extension Application.ActionRegistry {
    public var verifyEmailAction: VerifyEmailAction {
        VerifyEmailAction()
    }
}

extension Application.ActionRegistry.Provider {
    public static var calculateRouterAction: Self {
        .init {
            $0.actions.use {
                $0.actions.calculateRouterAction
            }
        }
    }
}



extension Application.ActionRegistry {
    public var calculateRouterAction: CalculateRouterAction {
        CalculateRouterAction()
    }
}
