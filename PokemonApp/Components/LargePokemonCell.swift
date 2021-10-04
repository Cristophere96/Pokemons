//
//  LargePokemonCell.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 30/09/21.
//

import SwiftUI
import Kingfisher

struct LargePokemonCell: View {
    var pokemon: Pokemon
    @Binding var xPosition: CGFloat
    var likePokemon: () -> Void
    var dislikePokemon: () -> Void
    
    var body: some View {
        NavigationLink(destination: PokemonDetail(pokemon: pokemon)) {
            ZStack {
                VStack(alignment: .center) {
                    KFImage(URL(string: pokemon.sprites.front_default))
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width <= 320.0 ? UIScreen.main.bounds.width * 0.5 : UIScreen.main.bounds.width * 0.8,
                               height: UIScreen.main.bounds.width <= 320.0 ? UIScreen.main.bounds.width * 0.5 : UIScreen.main.bounds.width * 0.8)
                        .padding([.vertical, .horizontal], 20)
                    
                    Text(pokemon.name.capitalized)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical, 20)
                        .padding(.leading)
                    
                    HStack {
                        ForEach(pokemon.types, id: \.slot) { type in
                            Text(type.type.name.capitalized)
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .frame(width: 150, height: 40)
                        }
                    }
                    .padding(.bottom, 20)
                }
            }
            .background(Color(Utils.backgroundColor(forType: pokemon.types[0].type.name)))
            .cornerRadius(12)
            .shadow(color: Color(Utils.backgroundColor(forType: pokemon.types[0].type.name)), radius: 6, x: 0.0, y: 0.0)
            .offset(x: xPosition)
            .gesture(
                DragGesture()
                    .onChanged({ (value) in
                        xPosition = value.translation.width
                    })
                    .onEnded({ (value) in
                        if value.translation.width > 0 {
                            if value.translation.width > 100 {
                                likePokemon()
                            } else {
                                xPosition = 0
                            }
                        } else {
                            if value.translation.width < -100 {
                                dislikePokemon()
                            } else {
                                xPosition = 0
                            }
                        }
                    })
            )
        }
    }
}
