//
//  RecipeViewModel.swift
//  RecipeWizard
//
//  Created by Daniel Colman on 1/17/25.
//

import SwiftUI

@Observable
@MainActor
class HomeViewModel {
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

    private let imageLoader = ImageLoader()
    private let urlSession: URLSessionProtocol
    private let recipesURL = URL(
        string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!

    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func loadRecipes() async {
        loadingState = .loading
        do {
            let newRecipes = try await fetchRecipes()
            self.recipes = newRecipes
            if recipes.isEmpty {
                loadingState = .doneLoadingEmpty
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

    private func fetchRecipes() async throws -> [Recipe] {
        return try await Task { [urlSession] in
            let (data, _) = try await urlSession.data(from: recipesURL, delegate: nil)
            let decodedResponse = try JSONDecoder().decode(Recipes.self, from: data)
            
            return decodedResponse.recipes
        }.value
    }

    func getImage(_ recipe: Recipe) async throws -> UIImage {
        return try await Task { [imageLoader] in
            try await imageLoader.loadImage(recipe)
        }.value
    }
}
