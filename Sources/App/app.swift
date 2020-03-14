import Vapor

/// Creates an instance of Application. This is called from main.swift in the run target.
public func app(_ env: Environment) throws -> Application {
    var env = env
    try LoggingSystem.bootstrap(from: &env)
    let app = Application(env)
    try configure(app)
    return app
}
