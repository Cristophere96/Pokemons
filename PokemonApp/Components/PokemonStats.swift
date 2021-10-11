//
//  PokemonStats.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 8/10/21.
//

import SwiftUI

struct PokemonStats: View {
    var stats: [Stat]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ForEach(stats, id: \.stat.name) { stat in
                HStack {
                    Image(systemName: Utils.iconBasedOnPokemonStat(stat: stat.stat.name))
                        .foregroundColor(Utils.iconColorBasedOnPokemonStat(stat: stat.stat.name))
                    Text(stat.stat.name.capitalized)
                    Spacer()
                    Text("\(stat.baseStat)")
                }
            }
        }
    }
}
