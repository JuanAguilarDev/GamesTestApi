//
//  DatabaseManager.swift
//  GameTestApi
//
//  Created by Juan Aguilar on 07/08/25.
//

import Foundation
@preconcurrency import SQLite

/// Calls: let db = try await DataBaseManager.shared()

actor DataBaseManager {
    
    // propiedad privada opcional
    private static var _shared: DataBaseManager?
    
    /// Primer acceso: crea la instancia con `async init`.
    static func shared() async throws -> DataBaseManager {
        if let existing = _shared { return existing }
        let newManager = try await DataBaseManager()
        _shared = newManager
        return newManager
    }
    
    /// Database generic info
    private let databaseName = "GameTestApi.sqlite"
    private let tableName = "Games"
    /// Database info
    private var db: Connection
    private let games = Table("games")
    private let id = Expression<Int>("id")
    private let name = Expression<String>("name")
    private let age = Expression<Int>("age")
    
    // MARK: - Lifecycle
    private init() async throws {
        let url = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first!
            .appendingPathComponent(databaseName)
        
        try db = Connection(url.path)
        try createTableIfNeeded()
    }
    
    /// Create table
    private func createTableIfNeeded() throws {
        try db.run(games.create(ifNotExists: true) { table in
            table.column(id, primaryKey: .autoincrement)
            table.column(name)
            table.column(age)
        })
    }
    
    // MARK: - Public Methods
    func insertUser(name: String, age: Int) async throws {
        let insert = games.insert(self.name <- name, self.age <- age)
        try db.run(insert)
    }
    
    func getAllUsers() async throws -> [GameModel] {
        try db.prepare(games).map {
            GameModel(id: $0[id], name: $0[name], age: $0[age])
        }
    }
    
    func update(id userId: Int, to newName: String, age newAge: Int) async throws {
        let user = games.filter(self.id == userId)
        try db.run(user.update(self.name <- newName, self.age <- newAge))
    }
    
    func delete(id userId: Int) async throws {
        let user = games.filter(self.id == userId)
        try db.run(user.delete())
    }
}
