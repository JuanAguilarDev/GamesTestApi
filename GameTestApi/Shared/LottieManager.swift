//
//  LottieManager.swift
//  GameTestApi
//
//  Created by Juan Aguilar on 06/08/25.
//

import SwiftUI
import Lottie

@Observable
final class LottieManager {
    var currentAnimation: String = ""
    var loopMode: LottieLoopMode = .loop
    var contentMode: UIView.ContentMode = .scaleAspectFit
    
    func play(animation name: String, loopMode: LottieLoopMode = .loop) {
        self.currentAnimation = name
        self.loopMode = loopMode
    }
    
    func stop() {
        self.currentAnimation = ""
    }
    
    /// Reproduce una animación por un tiempo específico (en segundos) y luego la detiene.
    func play(animation name: String, for duration: TimeInterval, loopMode: LottieLoopMode = .loop) async {
        await MainActor.run {
            self.play(animation: name, loopMode: loopMode)
        }
        
        try? await Task.sleep(for: .seconds(duration))
        
        await MainActor.run {
            self.stop()
        }
    }
}
