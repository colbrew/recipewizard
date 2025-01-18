//
//  ImageDiskCacheTests.swift
//  RecipeWizard
//
//  Created by Daniel Colman on 1/18/25.
//

import UIKit
import Testing
@testable import RecipeWizard

struct ImageDiskCacheTests {
    let sut: ImageDiskCache
    let testImage = UIImage(named: "cake")!
    let mockFileManager = MockFileManager()
    
    init() throws {
        sut = ImageDiskCache(fileManager: mockFileManager)
    }
    
    @Test func testSaveImage() async throws {
        await sut.saveImage(id: "1", image: testImage)
        let imageURL = mockFileManager.recipeWizardCacheURL().appendingPathComponent("1.jpg", conformingTo: .fileURL)
        let fileExists = mockFileManager.fileExists(url: imageURL)
        #expect(fileExists)
    }

    @Test func testGetImageWhenOneDoesntExist() async throws {
        let image = await sut.getImage(id: "1")
        #expect(image == nil)
    }
    
    @Test func testGetImageWhenOneDoesExist() async throws {
        await sut.saveImage(id: "1", image: testImage)
        let image = await sut.getImage(id: "1")
        #expect(image != nil)
    }
    
    @Test func testDeleteImage() async throws {
        await sut.saveImage(id: "1", image: testImage)
        await sut.saveImage(id: "2", image: testImage)
        await sut.deleteImage(id: "1")
        let image1Exists = mockFileManager.fileExists(url: imageURL(name: "1.jpg"))
        print("1 \(image1Exists)")
        let image2Exists = mockFileManager.fileExists(url: imageURL(name: "2.jpg"))
        print("2 \(image1Exists)")
        #expect(!image1Exists)
        #expect(image2Exists)
    }
    
    @Test func testDeleteCache() async throws {
        await sut.saveImage(id: "1", image: testImage)
        await sut.saveImage(id: "2", image: testImage)
        await sut.saveImage(id: "3", image: testImage)
        let existsBeforeDelete = mockFileManager.fileExists(url: mockFileManager.recipeWizardCacheURL())
        #expect(existsBeforeDelete)
        await sut.deleteCache()
        let existsAfterDelete = mockFileManager.fileExists(url: mockFileManager.recipeWizardCacheURL())
        #expect(!existsAfterDelete)
    }
    
    func imageURL(name: String) -> URL {
        return mockFileManager.recipeWizardCacheURL().appendingPathComponent(name)
    }
}
