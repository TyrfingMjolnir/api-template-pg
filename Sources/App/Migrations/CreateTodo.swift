import Fluent

///psql postgres
///CREATE DATABASE yourdbname;
///CREATE USER youruser WITH ENCRYPTED PASSWORD 'yourpass';
///GRANT ALL PRIVILEGES ON DATABASE yourdbname TO youruser;
struct CreateTodo: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("todos")
            .field("id", .int, .identifier(auto: true))
            .field("title", .string, .required)
            .field("completed", .bool, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("todos").delete()
    }
}
