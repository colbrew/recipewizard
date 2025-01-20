//
//  ImageDiskCacheTests.swift
//  RecipeWizard
//
//  Created by Daniel Colman on 1/18/25.
//


@testable import RecipeWizard
import Testing
import UIKit

struct ImageDiskCacheTests {
    let sut: ImageDiskCache
    let mockFileManager = MockFileManager()
    
    init() throws {
        sut = ImageDiskCache(fileManager: mockFileManager)
    }
    
    @Test func testSaveImage() async throws {
        await sut.saveImage(id: "1", image: MockRecipeData.cakeImage)
        let imageURL = mockFileManager.recipeWizardCacheURL().appendingPathComponent("1.jpg", conformingTo: .fileURL)
        let fileExists = mockFileManager.fileExists(atPath: imageURL.path())
        #expect(fileExists)
    }

    @Test func testGetImageWhenOneDoesntExist() async throws {
        let image = await sut.getImage(id: "1")
        #expect(image == nil)
    }
    
    @Test func testGetImageWhenOneDoesExist() async throws {
        await sut.saveImage(id: "1", image: MockRecipeData.cakeImage)
        let image = await sut.getImage(id: "1")
        #expect(image != nil)
    }
    
    @Test func testDeleteImage() async throws {
        await sut.saveImage(id: "1", image: MockRecipeData.cakeImage)
        await sut.saveImage(id: "2", image: MockRecipeData.cakeImage)
        await sut.deleteImage(id: "1")
        
        let image1Exists = mockFileManager.fileExists(atPath: imageURL(name: "1.jpg").path())
        let image2Exists = mockFileManager.fileExists(atPath: imageURL(name: "2.jpg").path())
        #expect(!image1Exists)
        #expect(image2Exists)
    }
    
    @Test func testDeleteCache() async throws {
        await sut.saveImage(id: "1", image: MockRecipeData.cakeImage)
        await sut.saveImage(id: "2", image: MockRecipeData.cakeImage)
        await sut.saveImage(id: "3", image: MockRecipeData.cakeImage)
        let existsBeforeDelete = mockFileManager.fileExists(atPath: mockFileManager.recipeWizardCacheURL().path())
        #expect(existsBeforeDelete)
        await sut.deleteCache()
        let existsAfterDelete = mockFileManager.fileExists(atPath: mockFileManager.recipeWizardCacheURL().path())
        #expect(!existsAfterDelete)
    }
    
    func imageURL(name: String) -> URL {
        return mockFileManager.recipeWizardCacheURL().appendingPathComponent(name)
    }
}
