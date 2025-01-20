//
//  ErrorView.swift
//  RecipeWizard
//
//  Created by Daniel Colman on 1/17/25.
//

import SwiftUI

struct ErrorView: View {
    @Binding var homeVM: HomeViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "fork.knife")
                .resizable()
                .frame(width: 100, height: 100)
                .padding()
            Text("We're having trouble getting the cookbook.\n Try again in a bit.")
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .padding()
            Button("Try Again") {
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
    
    ErrorView(homeVM: $homeVM)
}
