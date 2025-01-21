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
    
    @Test func testLoadRecipes() async throws {
        let sut = HomeViewModel(urlSession: MockURLSessionRecipes())
        await sut.loadRecipes()
        #expect(sut.recipes == MockRecipeData.allRecipes)
        #expect(sut.cuisines == ["All", "Malaysian", "British"])
        #expect(sut.loadingState == .doneLoading)
    }
    
    @Test func testLoadRecipesFailure() async throws {
        let sut = HomeViewModel(urlSession: MockURLSessionThrows())
        await sut.loadRecipes()
        #expect(sut.recipes == [])
        #expect(sut.cuisines == ["All"])
        #expect(sut.loadingState == .failure)
    }
    
    @Test func testLoadRecipesEmpty() async throws {
        let sut = HomeViewModel(urlSession: MockURLSessionNoRecipes())
        await sut.loadRecipes()
        #expect(sut.recipes == [])
        #expect(sut.cuisines == ["All"])
        #expect(sut.loadingState == .doneLoadingEmpty)
    }
}
