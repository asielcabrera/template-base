import Vapor

// Define a command to list all routes
struct ListRoutesCommand: Command {
    // The command's identifier
    let name = "list-routes"

    // Short description of the command
    let help = "Lists all routes defined in the application."

    // Command signature (arguments)
    struct Signature: CommandSignature {}

    // Execute the command logic
    func run(using context: CommandContext, signature: Signature) throws {
        let app = context.application

        // Loop through all the routes and print their details
        app.routes.all.forEach { route in
            let methods = route.method.string.uppercased()
            let path = route.path.map(\.description).joined(separator: "/")
            context.console.print("\(methods) /\(path)")
        }
    }
}
