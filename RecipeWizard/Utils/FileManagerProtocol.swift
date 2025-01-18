//
//  FileManagerProtocol.swift
//  RecipeWizard
//
//  Created by Daniel Colman on 1/18/25.
//

import Foundation

protocol FileManagerProtocol {
    func createDirectory(url: URL) throws
    func removeItem(url: URL) throws
    func createFile(url: URL, contents: Data)
    func contents(url: URL) -> Data?
    func recipeWizardCacheURL() -> URL
    func fileExists(url: URL) -> Bool
}
