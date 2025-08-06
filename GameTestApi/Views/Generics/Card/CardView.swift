//
//  CardView.swift
//  GameTestApi
//
//  Created by Juan Aguilar on 06/08/25.
//

import SwiftUI

struct CardView: View {
    let game: GameModel
    
    var body: some View {
        Text("Hello, World!")
    }
}

@available(iOS 17.0, *)
#Preview(traits: .sizeThatFitsLayout) {
    GameCard(game: .dummyGame)
}

struct GameCard: View {
    let game: GameModel
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: game.thumbnail)) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(height: 120)
            .clipped()
            
            Text(game.title).font(.headline)
            Text("\(game.genre) · \(game.platform) · \( game.releaseDate)")
                .font(.subheadline).foregroundStyle(.secondary)
            Text(game.shortDescription)
                .font(.caption).lineLimit(1)
            
            Link(destination: URL(string: game.gameUrl)!) {
                Image(systemName: "arrow.up.right")
            }
            .padding(.top, 4)
        }
        .padding()
        .background(.regularMaterial)
        .cornerRadius(8)
    }
}
