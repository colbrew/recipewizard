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
            VStack(alignment: .center) {
                RecipeImageView(recipe: recipe)
                HStack {
                    Text(recipe.name)
                        .font(.title3)
                    Spacer()
                    Text(recipe.cuisine)
                        .font(.headline)
                }
            }
            .containerRelativeFrame(.horizontal) { size, axis in
                size * 0.9}
        }
    }
}

#Preview {
    RecipeView(recipe: MockRecipeData.singleRecipe)
}
