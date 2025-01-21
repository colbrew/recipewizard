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
    let recipeWizardCacheURL = URL(string: "RecipeWizardCache")!
    
    @Test func testSaveImage() async throws {
        let sut = ImageDiskCache(fileManager: MockFileManager())
        await sut.saveImage(id: "1", image: MockRecipeData.cakeImage)
        let imageURL = recipeWizardCacheURL.appendingPathComponent("1.jpg", conformingTo: .fileURL)
        let fileExists = await sut.fileExists(atPath: imageURL.path())
        #expect(fileExists)
    }

    @Test func testGetImageWhenOneDoesntExist() async throws {
        let mockFileManager = MockFileManager()
        let sut = ImageDiskCache(fileManager: mockFileManager)
        let image = await sut.getImage(id: "1")
        #expect(image == nil)
    }
    
    @Test func testGetImageWhenOneDoesExist() async throws {
        let mockFileManager = MockFileManager()
        let sut = ImageDiskCache(fileManager: mockFileManager)
        await sut.saveImage(id: "1", image: MockRecipeData.cakeImage)
        let image = await sut.getImage(id: "1")
        #expect(image != nil)
    }
    
    @Test func testDeleteImage() async throws {
        let sut = ImageDiskCache(fileManager: MockFileManager())
        await sut.saveImage(id: "1", image: MockRecipeData.cakeImage)
        await sut.saveImage(id: "2", image: MockRecipeData.cakeImage)
        await sut.deleteImage(id: "1")
        
        let image1URL = recipeWizardCacheURL.appendingPathComponent("1.jpg")
        let image1Exists = await sut.fileExists(atPath: image1URL.path())
        let image2URL = recipeWizardCacheURL.appendingPathComponent("2.jpg")
        let image2Exists = await sut.fileExists(atPath: image2URL.path())
        #expect(!image1Exists)
        #expect(image2Exists)
    }
    
    @Test func testDeleteCache() async throws {
        let sut = ImageDiskCache(fileManager: MockFileManager())
        await sut.saveImage(id: "1", image: MockRecipeData.cakeImage)
        await sut.saveImage(id: "2", image: MockRecipeData.cakeImage)
        await sut.saveImage(id: "3", image: MockRecipeData.cakeImage)
        
        let existsBeforeDelete = await sut.fileExists(atPath: recipeWizardCacheURL.path())
        #expect(existsBeforeDelete)
        await sut.deleteCache()
        let existsAfterDelete = await sut.fileExists(atPath: recipeWizardCacheURL.path())
        #expect(!existsAfterDelete)
    }
}

extension ImageDiskCache {
    func fileExists(atPath path: String) -> Bool{
        return fileManager.fileExists(atPath: path)
    }
}
