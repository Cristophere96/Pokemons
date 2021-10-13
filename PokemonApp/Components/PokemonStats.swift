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
                HStack(spacing: 10) {
                    Image(systemName: Utils.iconBasedOnPokemonStat(stat: stat.stat.name))
                        .foregroundColor(Utils.iconColorBasedOnPokemonStat(stat: stat.stat.name))
                    Text(stat.stat.name.capitalized)
                        .font(.callout)
                    Spacer()
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .foregroundColor(.gray)
                        .overlay(
                            HStack {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)                                    .foregroundColor(Utils.iconColorBasedOnPokemonStat(stat: stat.stat.name))
                                    .frame(width: CGFloat(stat.baseStat))
                                if 100 - stat.baseStat > 0 {
                                    Spacer(minLength: CGFloat(100 - stat.baseStat))
                                }
                            }
                        )
                        .frame(width: 100, height: 15)
                    if stat.baseStat > 100 {
                        Spacer()
                    }
                    Text("\(stat.baseStat)")
                }
            }
        }
    }
}
