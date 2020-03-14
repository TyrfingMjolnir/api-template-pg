import Fluent
import Vapor

/// A single entry of a Todo list.
final class Todo: Model {
    static let schema = "todos"
    
    @ID(key: "id")
    var id: Int?

    @Field(key: "title")
    var title: String
    
    @Field(key: "completed")
    var completed: Bool
    
    init() { }
    
    init(id: Int? = nil, title: String, completed: Bool = false) {
        self.id = id
        self.title = title
        self.completed = completed
    }
}

/// Allows `Todo` to be encoded to and decoded from HTTP messages.
extension Todo: Content { }
