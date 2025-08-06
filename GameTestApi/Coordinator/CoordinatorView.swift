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
            DashboardView(viewModel: DashboardViewModel(and: coordinator))
                .navigationDestination(for: Route.self, destination: { route in
                    switch route {
                    default:
                        DashboardView(viewModel: DashboardViewModel(and: coordinator))
                    }
                })
        }
        .environmentObject(coordinator)
    }
}
