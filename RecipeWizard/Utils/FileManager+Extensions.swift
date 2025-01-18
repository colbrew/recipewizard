//
//  FileManager+Extensions.swift
//  RecipeWizard
//
//  Created by Daniel Colman on 1/18/25.
//

import Foundation

extension FileManager: FileManagerProtocol {
    func createDirectory(url: URL) throws {
        try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
    }
    
    func removeItem(url: URL) throws {
        try FileManager.default.removeItem(at: url)
    }
    
    func createFile(url: URL, contents: Data) {
        FileManager.default.createFile(atPath: url.path(), contents: contents)
    }
    
    func contents(url: URL) -> Data? {
        FileManager.default.contents(atPath: url.path())
    }
    
    func recipeWizardCacheURL() -> URL {
        let cacheURL = FileManager.default.urls(
            for: .cachesDirectory, in: .userDomainMask
        ).first!
        let recipeWizardCache = cacheURL.appendingPathComponent("RecipeWizard")
        return recipeWizardCache
    }
    
    func fileExists(url: URL) -> Bool {
        FileManager.default.fileExists(atPath: url.path())
    }
}
