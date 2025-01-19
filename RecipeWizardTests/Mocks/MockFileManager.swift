//
//  MockFileManager.swift
//  RecipeWizard
//
//  Created by Daniel Colman on 1/18/25.
//

import Foundation
@testable import RecipeWizard

class MockFileManager: FileManagerProtocol {
    var cache: [String: Data] = [:]

    func createDirectory(at url: URL, withIntermediateDirectories createIntermediates: Bool, attributes: [FileAttributeKey : Any]?) throws {
        cache[url.path()] = Data()
    }
    
    func createFile(atPath path: String, contents data: Data?, attributes attr: [FileAttributeKey : Any]?) -> Bool {
        if let data {
            cache[path] = data
            return true
        }
        return false
    }
    
    func contents(atPath path: String) -> Data? {
        if let data = cache[path] {
            return data
        }

        return nil
    }
    
    func fileExists(atPath path: String) -> Bool {
        return cache[path] != nil
    }

    func removeItem(at url: URL) throws {
        cache[url.path()] = nil
    }
    
    func recipeWizardCacheURL() -> URL {
        URL(string: "RecipeWizardCache")!
    }
}
