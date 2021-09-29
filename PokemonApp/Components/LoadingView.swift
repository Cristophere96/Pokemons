//
//  LoadingView.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 26/06/21.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            ProgressView()
                .offset(y: -40.0)
                .progressViewStyle(CircularProgressViewStyle(tint: .red))
                .scaleEffect(2)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
