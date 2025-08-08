//
//  CoordinatorView.swift
//  GameTestApi
//
//  Created by Juan Aguilar on 06/08/25.
//

import SwiftUI
import SwiftData

struct CoordinatorView: View {
    @StateObject var coordinator = GamesCoordinator()
    let modelContainer: ModelContainer
    let gameDataManager: GameDataManager
    
    // MARK: - Data Manager
    init() {
        do {
            let container = try ModelContainer(for: GameModel.self)
            self.modelContainer = container
            self.gameDataManager = GameDataManager(modelContainer: container)
        } catch {
            fatalError("No se pudo crear ModelContainer: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            SplashView(viewModel: SplashViewViewModel(with: gameDataManager ,and: coordinator))
                .navigationDestination(for: Route.self, destination: { route in
                    switch route {
                    case .dashboard:
                        DashboardView(viewModel: DashboardViewModel(with: gameDataManager, and: coordinator))
                    case .error(let errorMessage):
                        ErrorView(viewModel: ErrorViewModel(with: errorMessage, and: coordinator))
                    default:
                        DashboardView(viewModel: DashboardViewModel(with: gameDataManager, and: coordinator))
                    }
                })
        }
        .environmentObject(coordinator)
    }
}
