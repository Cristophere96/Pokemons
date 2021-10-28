//
//  LoadingView.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 26/06/21.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            LottieView(fileName: "loading")
                .frame(width: 200, height: 200)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
