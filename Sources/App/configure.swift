import FluentPostgresDriver
import Fluent
import Vapor

func configure(_ app: Application) throws {
    app.provider(FluentProvider())

    // Configure a Postgres database
    app.databases.postgres(
        configuration: .init(
            hostname: "localhost",
            username: "vapor",
            password: "vapor",
            database: "vapor"
        ),
        on: app.make()
    )
    
    // Configure migrations
    app.register(Migrations.self) { app in
        var migrations = Migrations()
        migrations.add(CreateTodo())
        return migrations
    }
    
    try routes(app)
}
