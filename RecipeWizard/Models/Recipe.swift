//
//  Recipe.swift
//  RecipeWizard
//
//  Created by Daniel Colman on 1/17/25.
//

import Foundation

struct Recipe: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let cuisine: String
    let photoURL: URL

    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name
        case cuisine
        case photoURL = "photo_url_small"
    }
}

struct Recipes: Codable {
    let recipes: [Recipe]
}

struct MockRecipeData {
    static let allRecipes: [Recipe] = [
        Recipe(
            id: "1",
            name: "Apam Balik",
            cuisine: "Malaysian",
            photoURL: URL(
                string:
                    "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"
            )!),
        Recipe(
            id: "2",
            name: "Apple & Blackberry Crumble",
            cuisine: "British",
            photoURL: URL(
                string:
                    "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg"
            )!),
        Recipe(
            id: "3",
            name: "Apple Frangipan Tart",
            cuisine: "British",
            photoURL: URL(
                string:
                    "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/small.jpg"
            )!),
    ]

    static let singleRecipe = Recipe(
        id: "1",
        name: "Apam Balik",
        cuisine: "Malaysian",
        photoURL: URL(
            string:
                "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"
        )!)
}
