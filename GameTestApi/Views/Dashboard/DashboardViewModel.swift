//
//  DashboardViewModel.swift
//  GameTestApi
//
//  Created by Juan Aguilar on 05/08/25.
//

import SwiftUI

@Observable class DashboardViewModel : ObservableObject {
    var games: [GameModel] = []
    let manager: GamesServicesManager
    unowned let coordinator: GamesCoordinator
    
    init(with manager: GamesServicesManager = GamesServicesManager(), and coordinator: GamesCoordinator) {
        self.manager = manager
        self.coordinator = coordinator
    }
    
    func fetchGames() async throws {
        games = try await manager.fetchGames()
    }
    
    func showDetail() {
        //coordinator.push(.personDetail(person: person))
    }
}
