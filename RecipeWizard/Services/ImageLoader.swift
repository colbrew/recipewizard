//
//  ImageLoader.swift
//  RecipeWizard
//
//  Created by Daniel Colman on 1/18/25.
//

import UIKit

struct ImageLoader {
    let diskCache: ImageDiskCacheProtocol
    let urlSession: URLSessionProtocol
    
    init(diskCache: ImageDiskCacheProtocol = ImageDiskCache(),
         urlSession: URLSessionProtocol = URLSession.shared) {
        self.diskCache = diskCache
        self.urlSession = urlSession
    }
    
    func loadImage(_ recipe: Recipe) async throws -> UIImage? {
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

    private func fetchImage(url: URL) async throws -> UIImage? {
        let (data, response) = try await urlSession.data(from: url, delegate: nil)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        return UIImage(data: data)
    }
}
