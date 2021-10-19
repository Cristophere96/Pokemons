//
//  PokemonLargeImage.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 14/10/21.
//

import SwiftUI
import Kingfisher

struct PokemonLargeImage: View {
    var imageURL: String
    
    var body: some View {
        if #available(iOS 15, *) {
            AsyncImage(url: URL(string: imageURL)) { phase in
                switch phase {
                case .empty:
                    Image("pokemonEgg")
                        .redacted(reason: .placeholder)
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                case .success(let image):
                    image.resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .padding([.bottom, .trailing], 4)
                case .failure:
                    Image("pokemonEgg")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .padding([.bottom, .trailing], 4)
                @unknown default:
                    Image("pokemonEgg")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .padding([.bottom, .trailing], 4)
                }
            }
        } else {
            KFImage(URL(string: imageURL))
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding([.bottom, .trailing], 4)
        }
    }
}
