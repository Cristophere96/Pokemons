//
//  Utils.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 22/09/21.
//

import SwiftUI

public struct Utils {
    
    static func backgroundColor(forType type: String) -> UIColor {
        switch type {
        case "fire": return .systemRed
        case "grass" : return .systemGreen
        case "water" : return .systemBlue
        case "electric": return .systemYellow
        case "pshychic": return .systemPurple
        case "normal": return .systemOrange
        case "ground": return .systemGray
        case "flying": return .systemTeal
        case "fairy": return .systemPink
        default: return .systemIndigo
        }
    }
    
    static func parseWeigthAndHeigth(forValue value: Int) -> String {
        let result = Double(value).rounded() / 10.0
        return String(format: "%.2f", result)
    }
    
    static func iconBasedOnPokemonStat(stat: String) -> String {
        switch stat {
        case "hp":
            return "heart.fill"
        case "attack":
            return "bolt"
        case "defense":
            return "shield"
        case "special-attack":
            return "bolt.fill"
        case "special-defense":
            return "shield.fill"
        case "speed":
            return "bolt.fill"
        default:
            return "questionmark"
        }
    }
    
    static func iconColorBasedOnPokemonStat(stat: String) -> Color {
        switch stat {
        case "hp":
            return .red
        case "attack":
            return .green
        case "defense":
            return .blue
        case "special-attack":
            return .green
        case "special-defense":
            return .blue
        case "speed":
            return .yellow
        default:
            return .accentColor
        }
    }
}
