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
