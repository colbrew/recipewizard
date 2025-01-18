//
//  RecipeView.swift
//  RecipeWizard
//
//  Created by Daniel Colman on 1/17/25.
//

import SwiftUI

struct RecipeView: View {
    let recipe: Recipe
    
    var body: some View {
        HStack{
            Spacer()
            VStack(alignment: .center) {
                AsyncImage(url: recipe.photoURL){ image in
                    image
                        .resizable()
                        .scaledToFit()
                        .containerRelativeFrame(.horizontal) { size, axis in
                            size * 0.9}
                } placeholder: {
                    ProgressView()
                        .scaledToFit()
                        .containerRelativeFrame(.horizontal) { size, axis in
                            size * 0.9}
                }
                .aspectRatio(contentMode: .fit)
                HStack {
                    Text(recipe.name)
                        .font(.title3)
                    Spacer()
                    Text(recipe.cuisine)
                        .font(.headline)
                }
            }
            Spacer()
        }
    }
}

#Preview {
    RecipeView(recipe: MockRecipeData.singleRecipe)
}
