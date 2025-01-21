//
//  HomeViewModelTests.swift
//  RecipeWizardTests
//
//  Created by Daniel Colman on 1/19/25.
//

@testable import RecipeWizard
import Testing

@MainActor
struct HomeViewModelTests {
    let sut: HomeViewModel

    init() {
        sut = HomeViewModel()
    }

    @Test func testFilter() async throws {
        sut.recipes = MockRecipeData.allRecipes

        sut.filter = "All"
        #expect(sut.filteredRecipes == MockRecipeData.allRecipes)

        sut.filter = "Malaysian"
        #expect(sut.filteredRecipes == [MockRecipeData.singleRecipe])
    }
}
