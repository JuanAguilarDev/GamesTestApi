//
//  ErrorViewModel.swift
//  GameTestApi
//
//  Created by Juan Aguilar on 07/08/25.
//

import SwiftUI

@Observable class ErrorViewModel : ObservableObject {
    var lottieManager: LottieManager = LottieManager()
    var errorMessage: String?
    
    unowned let coordinator: GamesCoordinator
    
    init(with errorMessage: String = "", and coordinator: GamesCoordinator) {
        self.errorMessage = errorMessage
        self.coordinator = coordinator
    }
    
    func startAnimation() {
        lottieManager.play(animation: "error")
    }
    
    func stopAnimation() {
        lottieManager.stop()
    }
}
