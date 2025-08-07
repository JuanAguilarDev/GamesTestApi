//
//  SplashView.swift
//  GameTestApi
//
//  Created by Juan Aguilar on 06/08/25.
//

import SwiftUI

struct SplashView: View {
    @StateObject var viewModel: SplashViewViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            if !viewModel.lottieManager.currentAnimation.isEmpty {
                LottieView(animationName: viewModel.lottieManager.currentAnimation,
                           loopMode: viewModel.lottieManager.loopMode)
                .frame(width: 200, height: 200)
            }
        }
        .padding()
        .task {
            viewModel.startFetchingData()
        }
    }
    
}
