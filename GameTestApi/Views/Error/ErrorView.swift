//
//  ErrorView.swift
//  GameTestApi
//
//  Created by Juan Aguilar on 07/08/25.
//

import SwiftUI

struct ErrorView: View {
    @StateObject var viewModel: ErrorViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            if !viewModel.lottieManager.currentAnimation.isEmpty {
                LottieView(animationName: viewModel.lottieManager.currentAnimation,
                           loopMode: viewModel.lottieManager.loopMode)
                .frame(width: 500, height: 500)
                .clipped()
            }
            
            // Mensaje de error debajo
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .font(.body)
                    .bold()
                    .frame(width: 300)
                    .padding(.horizontal)
            }
            
            Spacer() // Empuja el contenido hacia arriba si hay espacio extra
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .navigationTitle("Error")
        .task {
            viewModel.startAnimation()
        }
        .onDisappear() {
            viewModel.stopAnimation()
        }
    }
}
