import Fluent
import Vapor

/// Controls basic CRUD operations on `Todo`s.
final class TodoController {
    /// Returns a list of all `Todo`s.
    func index(_ req: Request) throws -> EventLoopFuture<[Todo]> {
        let query = Todo.query(on: req.db)
        if let completed = req.query[Bool.self, at: "completed"] {
            query.filter(\.$completed == completed)
        }
        return query.all()
    }

    /// Returns a single `Todo`.
    func view(_ req: Request) throws -> EventLoopFuture<Todo> {
        return Todo.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    
    /// Saves a decoded `Todo` to the database.
    func create(_ req: Request) throws -> EventLoopFuture<Todo> {
        struct Create: Content {
            var title: String
            var completed: Bool?
        }
        
        let create = try req.content.decode(Create.self)
        let todo = Todo(
            title: create.title,
            completed: create.completed ?? false
        )
        return todo.save(on: req.db).map { todo }
    }
    
    /// Updates fields on a `Todo`.
    func update(_ req: Request) throws -> EventLoopFuture<Todo> {
        struct Update: Content {
            var title: String?
            var completed: Bool?
        }
        
        let update = try req.content.decode(Update.self)
        return Todo.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { todo in
                if let title = update.title {
                    todo.title = title
                }
                if let completed = update.completed {
                    todo.completed = completed
                }
                return todo.save(on: req.db)
                    .map { todo }
            }
    }

    /// Deletes a parameterized `Todo`.
    func delete(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Todo.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .map { .ok }
    }
    
    func clear(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Todo.query(on: req.db)
            .delete()
            .map { .ok }
    }
}
