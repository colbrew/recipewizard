//
//  RecipeImageView.swift
//  RecipeWizard
//
//  Created by Daniel Colman on 1/18/25.
//

import SwiftUI

struct RecipeImageView: View {
    @Binding var homeVM: HomeViewModel
    let recipe: Recipe
    @State var image: UIImage?
    @State var loadingState: LoadingState = .loading
    
    var body: some View {
        Group {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if loadingState == .loading {
                VStack(alignment: .center) {                ProgressView()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .aspectRatio(1, contentMode: .fit)
            } else if loadingState == .failure {
                Image(systemName: "fork.knife.circle")
                    .resizable()
                    .scaledToFit()
            }
        }
        .task {
            do {
                loadingState = .loading
                image = try await homeVM.getImage(recipe)
            } catch {
                loadingState = .failure
            }
        }
    }
}

#Preview {
    @Previewable @State var homeVM = HomeViewModel()
    
    RecipeImageView(homeVM: $homeVM, recipe: MockRecipeData.singleRecipe)
}
