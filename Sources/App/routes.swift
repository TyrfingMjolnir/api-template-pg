import Vapor

/// Register your application's routes here.
func routes(_ app: Application) throws {
    // Basic "Hello, world!" example
    app.get("hello", ":name") { req -> String in
        let name = req.parameters.get("name")!
        return "Hello, \(name)!"
    }
    
    struct JSONExample: Content {
        let name: String
        let age: Int
        let birthday: Date
    }
    
    app.get("json") { req -> JSONExample in
        return JSONExample(
            name: "Hello",
            age: 28,
            birthday: Date()
        )
    }

    try app.register(collection: TodoController())
}
