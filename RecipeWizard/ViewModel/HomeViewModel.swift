//
//  RecipeViewModel.swift
//  RecipeWizard
//
//  Created by Daniel Colman on 1/17/25.
//

import SwiftUI

@Observable
class HomeViewModel {
    private let recipesURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
    var recipes = [Recipe]()
    var cuisines: [String] = ["all"]
    
    var filteredRecipes: [Recipe] {
        if filter == "all" {
            return recipes
        }
        return recipes.filter { $0.cuisine == filter }
    }
    var loadFailure = false
    var filter: String = "all"
    
    func loadData() async {
        do {
            let (data, _) = try await URLSession.shared.data(from: recipesURL)
            let decodedResponse = try JSONDecoder().decode(Recipes.self, from: data)
            recipes = decodedResponse.recipes
            cuisines += recipes.map { $0.cuisine }
        } catch {
            loadFailure = true
        }
    }
    
    
}

enum CuisineFilter: String {
    case all
    case malaysian = "Malaysian"
    case british = "British"
}
