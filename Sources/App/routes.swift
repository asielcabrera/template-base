import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async throws in
        try await req.view.render("index", ["title": "Hello Vapor!"])
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    try app.group("api") { api in
//        try! api.register(collection: AuthenticationController())
        try api.register(collection: UserController())
    }
    
    app.group("views") { views in
        try! views.register(collection: AuthenticationViewController())
        
        try! views.register(collection: TestViewController())
    }
}
