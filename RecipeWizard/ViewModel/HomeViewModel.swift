//
//  RecipeViewModel.swift
//  RecipeWizard
//
//  Created by Daniel Colman on 1/17/25.
//

import SwiftUI

@Observable
class HomeViewModel {
    let imageLoader = ImageLoader()

    var recipes = [Recipe]()
    var filteredRecipes: [Recipe] {
        if filter == "All" {
            return recipes
        }
        return recipes.filter { $0.cuisine == filter }
    }
    var cuisines: Set<String> = ["All"]
    var loadingState: LoadingState = .loading
    var filter: String = "All"

    private let recipesURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!

    func loadRecipes() async {
        loadingState = .loading
        do {
            let (data, _) = try await URLSession.shared.data(from: recipesURL)
            let decodedResponse = try JSONDecoder().decode(Recipes.self, from: data)
            recipes = decodedResponse.recipes
            if recipes.isEmpty {
                loadingState = .failure
                return
            }
            let downloadedCuisines = recipes.map { $0.cuisine }
            downloadedCuisines.forEach { cuisine in
                cuisines.insert(cuisine)
            }
            loadingState = .doneLoading
        } catch {
            loadingState = .failure
        }
    }
}

