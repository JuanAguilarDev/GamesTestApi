//
//  GameDataManager.swift
//  GameTestApi
//
//  Created by Juan Aguilar on 07/08/25.
//
import SwiftData
import Foundation

@ModelActor
public actor GameDataManager {
    func create(_ game: GameModel) throws {
        let gameId = game.id
        let fetchDescriptor = FetchDescriptor<GameModel>(
            predicate: #Predicate { item in
                item.id == gameId
            }
        )
        let existing = try modelContext.fetch(fetchDescriptor)
        
        if existing.isEmpty {
            modelContext.insert(game)
            try modelContext.save()
        } else {
            // TODO: - Handle duplicated data
            print("Data already exists for \(game.id)")
        }
    }

    func fetchAllSortedByTitle() throws -> [GameModel] {
        try modelContext.fetch(
            FetchDescriptor<GameModel>(sortBy: [SortDescriptor(\.title)])
        )
    }

    func delete(_ game: GameModel) throws {
        modelContext.delete(game)
        try modelContext.save()
    }
    
    func updateDescription(for gameId: Int, to newDescription: String) throws {
        let fetchDescriptor = FetchDescriptor<GameModel>(
            predicate: #Predicate { item in
                item.id == gameId
            }
        )

        guard let existing = try modelContext.fetch(fetchDescriptor).first else {
            print("No se encontró el juego con id \(gameId)")
            return
        }

        existing.shortDescription = newDescription
        try modelContext.save()
    }
}
