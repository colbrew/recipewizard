//
//  ImageLoader.swift
//  RecipeWizard
//
//  Created by Daniel Colman on 1/18/25.
//

import UIKit

struct ImageLoader {
    
    static let diskCache = ImageDiskCache()
    static func loadImage(_ recipe: Recipe) async throws -> UIImage? {
        if let image = await diskCache.getImage(id: recipe.id) {
            print("image from cache")
            return image
        }
        
        print("image from download")
        if let downloadedImage = try await fetchImage(url: recipe.photoURL) {
            await diskCache.saveImage(id: recipe.id, image: downloadedImage)
            return downloadedImage
        } else {
            throw RecipeError.failureFetchingImage
        }
    }

    static func fetchImage(url: URL) async throws -> UIImage? {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Ensure the response is valid
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        // Convert data to UIImage
        return UIImage(data: data)
    }
}
