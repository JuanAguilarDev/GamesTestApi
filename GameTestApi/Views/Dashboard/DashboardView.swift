//
//  DashboardView.swift
//  GameTestApi
//
//  Created by Juan Aguilar on 05/08/25.
//

import SwiftUI

struct DashboardView: View {
    @StateObject var viewModel: DashboardViewModel
    @State private var searchText = ""
    @State private var showSuggestions = false
    
    var filteredGames: [GameModel] {
        if searchText.isEmpty {
            return viewModel.games
        }
        
        return viewModel.games.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.genre.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var suggestions: [String] {
        let matchingTitles = viewModel.games
            .map(\.title)
            .filter { $0.localizedCaseInsensitiveContains(searchText) }
        
        let matchingGenres = viewModel.games
            .map(\.genre)
            .filter { $0.localizedCaseInsensitiveContains(searchText) }
        
        return Array(Set(matchingTitles + matchingGenres)).sorted()
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 14) {
                HStack {
                    Text("🎮 Dashboard")
                        .font(.largeTitle)
                        .bold()
                    
                    Spacer()
                    
                    Button(action: {
                        // TODO: - Profile options
                    }) {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal)
                .padding(.top)
                
                VStack(spacing: 8){
                    TextField("Buscar por título o género...", text: $searchText)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .onChange(of: searchText, { oldValue, newValue in
                            showSuggestions = !newValue.isEmpty
                        })
                    
                    if showSuggestions && !suggestions.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(suggestions, id: \.self) { suggestion in
                                    Button {
                                        searchText = suggestion
                                        showSuggestions = false
                                    } label: {
                                        Text(suggestion)
                                        Text(suggestion)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 6)
                                            .background(Color.blue.opacity(0.15))
                                            .foregroundColor(.blue)
                                            .cornerRadius(12)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
            ScrollView {
                if filteredGames.isEmpty && !searchText.isEmpty {
                    Text("No se encontraron juegos.")
                        .foregroundColor(.secondary)
                        .padding()
                } else {
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)], spacing: 10) {
                        ForEach(filteredGames, id: \.id) { game in
                            CardView(game: game) {
                                viewModel.coordinator.presentDetail(for: game)
                            } onToggleFavorite: {
                                // TODO: - Action for favorite
                            }
                            
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
        .task {
            try? await viewModel.fetchGames()
        }
        .refreshable {
            try? await viewModel.fetchGames()
        }
        .toolbar(.hidden)
        .sheet(item: $viewModel.coordinator.sheetToShow) { sheet in
            switch sheet {
            case .detail(let game):
                DetailView(game: game) {
                    viewModel.coordinator.dismissSheet()
                } onUpdateDescription: { description in
                    Task {
                        await viewModel.updateDescription(game: game, with: description)
                        try? await viewModel.fetchGames()
                    }
                } onDelete: {
                    Task {
                        await viewModel.deleteGame(game: game)
                        try? await viewModel.fetchGames()
                    }
                }
                
            }
        }
    }
}
