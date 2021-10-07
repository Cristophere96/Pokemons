//
//  GenerationCell.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 27/06/21.
//

import SwiftUI

struct GenerationCell: View {
    let title: String
    let image: String
    let limit: Int
    let offset: Int
    
    var body: some View {
        Button(action: {}, label: {
            NavigationLink(
                destination: PokemonsView(limit: limit, offset: offset, title: title),
                label: {
                    VStack {
                        Text(title)
                            .font(.headline)
                            .foregroundColor(Color(.label))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                        
                        Image(image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width * 0.4, height: 90)
                            .padding([.bottom, .trailing], 4)
                    }
                }
            )
        })
        .accessibilityIdentifier(image)
    }
}

struct GenerationCell_Previews: PreviewProvider {
    static var previews: some View {
        GenerationCell(title: "First generation", image: "first_gen", limit: 151, offset: 0)
    }
}
