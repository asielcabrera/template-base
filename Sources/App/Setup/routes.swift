import Fluent
import Vapor

func routes(_ app: Application) throws {

    try app.register(collection: IndexController())
    try app.group("api") { api in
        try api.register(collection: PatientController())
        try api.register(collection: AuthController())
        try api.register(collection: TripsController())
        
    }
    
    try app.group("views") { views in
        try views.register(collection: AuthenticationViewController())      
        try views.register(collection: TestViewController())
    }
}
