//
//  MockFileManager.swift
//  RecipeWizard
//
//  Created by Daniel Colman on 1/18/25.
//


import Foundation
@testable import RecipeWizard

class MockFileManager: FileManagerProtocol {
    
    var cache: [URL: Data] = [:]
    
    func createDirectory(url: URL) throws {
        cache[url] = Data()
    }
    
    func removeItem(url: URL) throws {
        cache[url] = nil
    }
    
    func createFile(url: URL, contents: Data) {
        cache[url] = contents
    }
    
    func contents(url: URL) -> Data? {
        if let data = cache[url] {
            return data
        }
        
        return nil
    }
    
    func fileExists(url: URL) -> Bool {
        return cache[url] != nil
    }
    
    func recipeWizardCacheURL() -> URL {
        URL(string: "RecipeWizardCache")!
    }
}
