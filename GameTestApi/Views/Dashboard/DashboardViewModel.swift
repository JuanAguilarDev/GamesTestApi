//
//  DashboardViewModel.swift
//  GameTestApi
//
//  Created by Juan Aguilar on 05/08/25.
//

import SwiftUI

@Observable class DashboardViewModel : ObservableObject {
    var games: [GameModel] = []
    let manager: GameDataManager
    unowned var coordinator: GamesCoordinator
    
    init(with manager: GameDataManager, and coordinator: GamesCoordinator) {
        self.manager = manager
        self.coordinator = coordinator
    }
    
    func fetchGames() async throws {
        games = try await manager.fetchAllSortedByTitle()
    }
    
    func updateDescription(game: GameModel, with newDescription: String) async {
        do {
            try await manager.updateDescription(for: game.id, to: newDescription)
        } catch {
            print("No se pudo actualizar la descripcion")
        }
    }
    
    func deleteGame(game: GameModel) async {
        do {
            try await manager.delete(game)
        } catch {
            print("No se pudo eliminar el juego")
        }
    }
}
