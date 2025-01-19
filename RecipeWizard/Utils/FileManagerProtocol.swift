//
//  FileManagerProtocol.swift
//  RecipeWizard
//
//  Created by Daniel Colman on 1/18/25.
//

import Foundation

protocol FileManagerProtocol {
    func createDirectory(at url: URL, withIntermediateDirectories createIntermediates: Bool, attributes: [FileAttributeKey : Any]?) throws
    func removeItem(at URL: URL) throws
    func createFile(atPath path: String, contents data: Data?, attributes attr: [FileAttributeKey : Any]?) -> Bool
    func contents(atPath path: String) -> Data?
    func fileExists(atPath path: String) -> Bool
    
    func recipeWizardCacheURL() -> URL
}

extension FileManager: FileManagerProtocol {
    func recipeWizardCacheURL() -> URL {
        let cacheURL = FileManager.default.urls(
            for: .cachesDirectory, in: .userDomainMask
        ).first!
        let recipeWizardCache = cacheURL.appendingPathComponent("RecipeWizard")
        return recipeWizardCache
    }
}
