//
//  ImageLoaderTests.swift
//  RecipeWizardTests
//
//  Created by Daniel Colman on 1/18/25.
//

@testable import RecipeWizard
import Testing
import UIKit

struct ImageLoaderTests {

    @Test func testLoadImageNoCache () async throws {
        let sut = ImageLoader(diskCache: MockImageDiskCache(),
                          urlSession: MockURLSession())
        let image = try await sut.loadImage(MockRecipeData.singleRecipe)

        #expect(image?.size == MockRecipeData.cakeImage.size)
    }

    @Test func testLoadImageFromCache () async throws {
        let cacheWithIceCream = MockImageDiskCache(cache: ["1": MockRecipeData.iceCreamImage])
        let sut = ImageLoader(diskCache: cacheWithIceCream,
                          urlSession: MockURLSession())

        let image = try await sut.loadImage(MockRecipeData.singleRecipe)

        #expect(image?.size == MockRecipeData.iceCreamImage.size)
    }

    @Test func testLoadImageURLSessionThrows () async throws {
        let sut = ImageLoader(diskCache: MockImageDiskCache(),
                              urlSession: MockURLSessionThrows())

        await #expect(throws: URLError(.badURL)) {
            _ = try await sut.loadImage(MockRecipeData.singleRecipe)
        }
    }

    @Test func testLoadImageNon200Response () async throws {
        let sut = ImageLoader(diskCache: MockImageDiskCache(),
                              urlSession: MockURLSessionNon200())

        await #expect(throws: URLError(.badServerResponse)) {
            _ = try await sut.loadImage(MockRecipeData.singleRecipe)
        }
    }

    @Test func testLoadImageBadImageData () async throws {
        let sut = ImageLoader(diskCache: MockImageDiskCache(),
                              urlSession: MockURLSessionBadData())

        await #expect(throws: RecipeError.failureFetchingImage) {
            _ = try await sut.loadImage(MockRecipeData.singleRecipe)
        }
    }
}
