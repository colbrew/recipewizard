//
//  ImageDiskCache.swift
//  RecipeWizard
//
//  Created by Daniel Colman on 1/18/25.
//

import Foundation
import UIKit

actor ImageDiskCache: ImageDiskCacheProtocol {
    let fileManager: FileManagerProtocol
    let recipeWizardCacheURL: URL

    init(fileManager: FileManagerProtocol = FileManager.default) {
        self.fileManager = fileManager
        self.recipeWizardCacheURL = fileManager.recipeWizardCacheURL()
        #if DEBUG
        let checkCacheReset = true
        #else
        let checkCacheReset = false
        #endif
        if checkCacheReset && ProcessInfo.processInfo.environment["resetCacheAtStart"] == "true" {
                try? fileManager.removeItem(at: recipeWizardCacheURL)
                URLCache.shared.removeAllCachedResponses()
        }
    }
    
    func getImage(id: String) -> UIImage? {
        setupDirectory()
        if let data = fileManager.contents(atPath: imageURL(id: id).path()) {
            return UIImage(data: data)
        }

        return nil
    }

    func saveImage(id: String, image: UIImage) {
        setupDirectory()

        if let data = image.jpegData(compressionQuality: 1.0) {
            let imageSaved = fileManager.createFile(atPath: imageURL(id: id).path(), contents: data, attributes: nil)
            if !imageSaved {
                print("Unable to save image") // in production, this would be logging
            }
        }
    }

    func deleteImage(id: String) {
        setupDirectory()
        try? fileManager.removeItem(at: imageURL(id: id))
    }

    func deleteCache() {
        try? fileManager.removeItem(at: recipeWizardCacheURL)
    }

    private func setupDirectory() {
        if !fileManager.fileExists(atPath: recipeWizardCacheURL.path) {
            do {
                try fileManager.createDirectory(at: recipeWizardCacheURL,
                                                withIntermediateDirectories: true,
                                                attributes: nil)
            } catch {
                print("unable to create directory") // in production, this would be logging
            }
        }
    }

    private func imageURL(id: String) -> URL {
        recipeWizardCacheURL.appendingPathComponent("\(id).jpg")
    }
}
