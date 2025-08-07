//
//  CoordinatorView.swift
//  GameTestApi
//
//  Created by Juan Aguilar on 06/08/25.
//

import SwiftUI

struct CoordinatorView: View {
    @StateObject var coordinator = GamesCoordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            SplashView(viewModel: SplashViewViewModel(and: coordinator))
                .navigationDestination(for: Route.self, destination: { route in
                    switch route {
                    case .dashboard:
                        DashboardView(viewModel: DashboardViewModel(and: coordinator))
                    case .error(let errorMessage):
                        ErrorView(viewModel: ErrorViewModel(with: errorMessage, and: coordinator))
                    default:
                        DashboardView(viewModel: DashboardViewModel(and: coordinator))
                    }
                })
        }
        .environmentObject(coordinator)
    }
}
