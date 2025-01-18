//
//  ImageDiskCache.swift
//  RecipeWizard
//
//  Created by Daniel Colman on 1/18/25.
//

import Foundation
import UIKit

actor ImageDiskCache {
    let fileManager: FileManagerProtocol
    let recipeWizardCacheURL: URL

    init(fileManager: FileManagerProtocol = FileManager.default) {
        self.fileManager = fileManager
        self.recipeWizardCacheURL = fileManager.recipeWizardCacheURL()
        if ProcessInfo.processInfo.environment["resetCacheAtStart"] == "true" {
                try? fileManager.removeItem(url: recipeWizardCacheURL)
        }
    }
    
    func getImage(id: String) -> UIImage? {
        setupDirectory()
        if let data = fileManager.contents(url: imageURL(id: id)) {
            return UIImage(data: data)
        }

        return nil
    }

    func saveImage(id: String, image: UIImage) {
        setupDirectory()

        if let data = image.jpegData(compressionQuality: 1.0) {
            fileManager.createFile(url: imageURL(id: id), contents: data)
        }
    }

    func deleteImage(id: String) {
        setupDirectory()
        try? fileManager.removeItem(url: imageURL(id: id))
    }

    func deleteCache() {
        try? fileManager.removeItem(url: recipeWizardCacheURL)
    }

    func setupDirectory() {
        do {
            try fileManager.createDirectory(url: recipeWizardCacheURL)
        } catch {
            print("unable to creat directory")
        }
    }

    func imageURL(id: String) -> URL {
        recipeWizardCacheURL.appendingPathComponent("\(id).jpg")
    }
}
