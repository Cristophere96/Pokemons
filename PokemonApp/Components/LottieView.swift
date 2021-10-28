//
//  LottieView.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 28/10/21.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    var fileName: String
    
    typealias UIViewType = UIView
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        let animationView = AnimationView()
        let animation = Animation.named(fileName)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView,
                      context: UIViewRepresentableContext<LottieView>) {  }
}
