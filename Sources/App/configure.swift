import FluentPostgresDriver
import Fluent
import Vapor

func configure(_ app: Application) throws {
    // Configure a Postgres database
    app.databases.use(.postgres(
        hostname: "localhost",
        username: "vapor",
        password: "vapor",
        database: "vapor"
        ), as: .psql)

    app.migrations.add(CreateTodo())
    
    try routes(app)
}
