//
//  SplashViewViewModel.swift
//  GameTestApi
//
//  Created by Juan Aguilar on 06/08/25.
//

import SwiftUI

@Observable class SplashViewViewModel : ObservableObject {
    // MARK: - General Properties
    var games: [GameModel] = []
    var isLoading: Bool = true
    var errorMessage: String = ""
    unowned let coordinator: GamesCoordinator
    
    // MARK: - Managers
    var lottieManager: LottieManager = LottieManager()
    private let localDataManager: GameDataManager
    private let serviceManager: GamesServicesManager = GamesServicesManager()
    
    init(with manager: GameDataManager, and coordinator: GamesCoordinator) {
        self.localDataManager = manager
        self.coordinator = coordinator
    }
    
    @MainActor
    func startFetchingData() {
        Task {
            async let fetchGamesTask = fetchGames()
            async let animation: () = lottieManager.play(animation: "loading", for: 2.5)
            
            let (result, _) = await (fetchGamesTask, animation)
            await handle(result)
        }
    }
    
    @MainActor
    private func saveGames() async {
        await withTaskGroup(of: Void.self){ group in
            for game in games {
                group.addTask { [weak self] in
                    guard let self = self else { return }
                    
                    do {
                        try await localDataManager.create(game)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                    
                }
            }
        }
        coordinator.goToDashboard()
    }
    
    @MainActor
    private func handle(_ result: Result<[GameModel], Error>) async {
        defer {
            isLoading = false
            lottieManager.stop()
        }
        
        switch result {
        case .success(let games):
            self.games = games
            await saveGames()
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
