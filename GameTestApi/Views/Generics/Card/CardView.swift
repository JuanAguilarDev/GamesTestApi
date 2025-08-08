//
//  CardView.swift
//  GameTestApi
//
//  Created by Juan Aguilar on 06/08/25.
//

import SwiftUI

struct CardView: View {
    let game: GameModel
    let onAddToCart: () -> Void
    let onToggleFavorite: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: URL(string: game.thumbnail)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(height: 95)
                .clipped()
                
                Button(action: onToggleFavorite) {
                    Image(systemName: "heart")
                        .padding(10)
                        .foregroundColor(.gray)
                        .background(Color.white.opacity(0.8))
                        .clipShape(Circle())
                        .padding()
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(game.title)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 30)
                
                HStack {
                    Label(game.genre, systemImage: "gamecontroller")
                        .padding(6)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(4)
                }
                
                Text(game.shortDescription)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                
                HStack {
                    Button(action: onAddToCart) {
                        Text("Ver Mas")
                            .frame(maxWidth: .infinity)
                            .font(.subheadline)
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .frame(maxWidth: .infinity)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 8)
    }
}

#Preview {
    CardView(game: .dummyGame) {
        print("Vista detalle")
    } onToggleFavorite: {
        print("Agregado a favoritos")
    }
    
}
