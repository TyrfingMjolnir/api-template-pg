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

    // Example of configuring a controller
    let todoController = TodoController()
    let todos = app.grouped("todos")
    let todo = todos.grouped(":id")
    todos.get(use: todoController.index)
    todo.get(use: todoController.view)
    todos.post(use: todoController.create)
    todo.patch(use: todoController.update)
    todos.delete(use: todoController.clear)
    todo.delete(use: todoController.delete)
}
