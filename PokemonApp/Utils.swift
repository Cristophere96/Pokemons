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
}
