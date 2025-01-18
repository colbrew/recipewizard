//
//  RecipeImageView.swift
//  RecipeWizard
//
//  Created by Daniel Colman on 1/18/25.
//

import SwiftUI

struct RecipeImageView: View {
    let recipe: Recipe
    @State var image: UIImage?
    @State var loadingFailed = false
    
    var body: some View {
        Group {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if loadingFailed {
                Text("Unable ot load image at this time.")
            } else {
                ProgressView()
            }
        }
        .task {
            do {
                image = try await ImageLoader.loadImage(recipe)
            } catch {
                loadingFailed = true
            }
        }
    }
}

#Preview {
    RecipeImageView(recipe: MockRecipeData.singleRecipe)
}
