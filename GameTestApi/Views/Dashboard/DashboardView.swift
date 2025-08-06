//
//  DashboardView.swift
//  GameTestApi
//
//  Created by Juan Aguilar on 05/08/25.
//

import SwiftUI

struct DashboardView: View {
    @StateObject var viewModel: DashboardViewModel
    
    var body: some View {
        ScrollView {
             LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                 ForEach(viewModel.games, id: \.id) { game in
                 GameCard(game: game)
               }
             }
             .padding()
           }
        .task {
            try? await viewModel.fetchGames()
        }
    }
}

#Preview {
    DashboardView(viewModel: DashboardViewModel(and: GamesCoordinator()))
}
