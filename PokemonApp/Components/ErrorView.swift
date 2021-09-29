//
//  ErrorView.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 28/09/21.
//

import SwiftUI

struct ErrorView: View {
    var buttonAction: () -> Void
    var errorMessage: String
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 20) {
                Text("Oops! There's seems to be an error")
                    .font(.title2)
                    .fontWeight(.light)
                
                Text(errorMessage)
                    .font(.subheadline)
                    .foregroundColor(Color("background").opacity(0.5))
                
                Button(action: { buttonAction() }, label: {
                    VStack {
                        Text("Try again")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.5, height: 40)
                    .padding(.vertical, 6)
                    .background(Color.red)
                    .cornerRadius(8)
                })
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width - 20)
            .background(Color("background").opacity(0.05))
            .cornerRadius(10)
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(buttonAction: {  }, errorMessage: "No internet connection")
            .preferredColorScheme(.dark)
    }
}
