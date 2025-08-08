//
//  DetailView.swift
//  GameTestApi
//
//  Created by Juan Aguilar on 07/08/25.
//

import SwiftUI

struct DetailView: View {
    let game: GameModel
    // Callback para cerrar la hoja modal
    let onDismiss: () -> Void
    // Callbacks para editar y eliminar
    let onUpdateDescription: (String) -> Void
    let onDelete: () -> Void
    
    @State private var isEditing = false
    @State private var editedDescription = ""
    @State private var showDeleteAlert = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    AsyncImage(url: URL(string: game.thumbnail)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(maxWidth: .infinity, minHeight: 200)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity)
                                .cornerRadius(10)
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity, minHeight: 200)
                                .foregroundColor(.gray)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    
                    Text(game.title)
                        .font(.title)
                        .bold()
                    
                    Text(game.shortDescription)
                        .font(.body)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        DetailRow(title: "Género", value: game.genre)
                        DetailRow(title: "Plataforma", value: game.platform)
                        if let publisher = game.publisher {
                            DetailRow(title: "Publisher", value: publisher)
                        }
                        if let developer = game.developer {
                            DetailRow(title: "Developer", value: developer)
                        }
                        DetailRow(title: "Fecha de lanzamiento", value: game.releaseDate)
                    }
                    
                    if let profileUrlString = game.freeToGameProfileUrl,
                       let profileUrl = URL(string: profileUrlString) {
                        Link("Perfil en FreeToGame", destination: profileUrl)
                            .font(.headline)
                            .foregroundColor(.blue)
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Detalles del juego")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cerrar") {
                        onDismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button(action: {
                            editedDescription = game.shortDescription
                            isEditing = true
                        }) {
                            Text("Editar")
                        }
                        Button(role: .destructive) {
                            showDeleteAlert = true
                        } label: {
                            Image(systemName: "trash")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .sheet(isPresented: $isEditing) {
                NavigationView {
                    VStack {
                        TextEditor(text: $editedDescription)
                            .padding()
                            .navigationTitle("Editar descripción")
                            .navigationBarTitleDisplayMode(.inline)
                            .toolbar {
                                ToolbarItem(placement: .cancellationAction) {
                                    Button("Cancelar") {
                                        isEditing = false
                                    }
                                }
                                ToolbarItem(placement: .confirmationAction) {
                                    Button("Guardar") {
                                        onUpdateDescription(editedDescription)
                                        isEditing = false
                                    }
                                }
                            }
                    }
                }
            }
            .alert("¿Eliminar este juego?", isPresented: $showDeleteAlert) {
                Button("Eliminar", role: .destructive) {
                    onDelete()
                    onDismiss()
                }
                Button("Cancelar", role: .cancel) { }
            }
        }
    }
}

// Vista auxiliar para fila de detalle
struct DetailRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title + ":")
                .fontWeight(.semibold)
            Spacer()
            Text(value)
                .foregroundColor(.secondary)
        }
    }
}
