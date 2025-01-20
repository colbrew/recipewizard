//
//  ErrorView.swift
//  RecipeWizard
//
//  Created by Daniel Colman on 1/17/25.
//

import SwiftUI

struct ErrorView: View {
    @Binding var homeVM: HomeViewModel
    let message: String

    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "fork.knife")
                .resizable()
                .frame(width: 100, height: 100)
                .padding()
            Text(message)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .padding()
            Button(Constants.tryAgain) {
                Task {
                    await homeVM.loadRecipes()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(.yellow)
    }
}

#Preview {
    @Previewable @State var homeVM = HomeViewModel()
    
    ErrorView(homeVM: $homeVM,
              message: Constants.failFetchingRecipes)
}
