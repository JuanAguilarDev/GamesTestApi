//
//  SplashViewViewModel.swift
//  GameTestApi
//
//  Created by Juan Aguilar on 06/08/25.
//

import SwiftUI

@Observable class SplashViewViewModel : ObservableObject {
    var games: [GameModel] = []
    var lottieManager: LottieManager = LottieManager()
    var isLoading: Bool = true
    var errorMessage: String = ""
    
    unowned let coordinator: GamesCoordinator
    private let serviceManager: GamesServicesManager
    
    init(with manager: GamesServicesManager = GamesServicesManager(), and coordinator: GamesCoordinator) {
        self.serviceManager = manager
        self.coordinator = coordinator
    }
    
    @MainActor
    func startFetchingData() {
        Task {
            async let fetchGamesTask = fetchGames()
            async let animation: () = lottieManager.play(animation: "loading", for: 2.5)
            
            let (result, _) = await (fetchGamesTask, animation)
            handle(result)
        }
    }
    
    @MainActor
    private func handle(_ result: Result<[GameModel], Error>) {
        defer {
            isLoading = false
            lottieManager.stop()
        }
        
        switch result {
        case .success(let games):
            self.games = games
            coordinator.goToDashboard()
        case .failure(let error):
            errorMessage = error.localizedDescription.isEmpty ? ErrorEnum.serverError(code: 400).errorDescription : error.localizedDescription
            coordinator.goToError(with: errorMessage)
        }
    }
    
    // MARK: - Services
    func fetchGames() async -> Result<[GameModel], Error> {
        do {
            let games = try await serviceManager.fetchGames()
            return .success(games)
        } catch {
            return .failure(error)
        }
    }
    
}
