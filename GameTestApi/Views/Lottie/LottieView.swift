//
//  LottieView.swift
//  GameTestApi
//
//  Created by Juan Aguilar on 06/08/25.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    var animationName: String
    var loopMode: LottieLoopMode = .loop
    var contentMode: UIView.ContentMode = .scaleAspectFit
    
    func makeUIView(context: Context) -> LottieAnimationView {
        let view = LottieAnimationView(name: animationName)
        view.loopMode = loopMode
        view.contentMode = contentMode
        view.play()
        return view
    }
    
    func updateUIView(_ uiView: LottieAnimationView, context: Context) {
        uiView.animation = LottieAnimation.named(animationName)
        uiView.loopMode = loopMode
        uiView.play()
    }
}
