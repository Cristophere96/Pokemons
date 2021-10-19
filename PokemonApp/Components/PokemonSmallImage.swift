//
//  PokemonSmallImage.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 14/10/21.
//

import SwiftUI
import Kingfisher

struct PokemonSmallImage: View {
    var imageURL: String
    
    var body: some View {
        if #available(iOS 15, *) {
            AsyncImage(url: URL(string: imageURL)) { phase in
                switch phase {
                case .empty:
                    Image("pokemonEgg")
                        .redacted(reason: .placeholder)
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                case .success(let image):
                    image.resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width * 0.22, height: UIScreen.main.bounds.width * 0.22)
                        .padding(.bottom, 8)
                case .failure:
                    Image("pokemonEgg")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width * 0.22, height: UIScreen.main.bounds.width * 0.22)
                        .padding(.bottom, 8)
                @unknown default:
                    Image("pokemonEgg")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width * 0.22, height: UIScreen.main.bounds.width * 0.22)
                        .padding(.bottom, 8)
                }
            }
        } else {
            KFImage(URL(string: imageURL))
                .frame(width: UIScreen.main.bounds.width * 0.22, height: UIScreen.main.bounds.width * 0.22)
                .padding(.bottom, 8)
        }
    }
}
