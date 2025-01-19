//
//  MockImageDiskCache.swift
//  RecipeWizard
//
//  Created by Daniel Colman on 1/18/25.
//

@testable import RecipeWizard
import UIKit

actor MockImageDiskCache: ImageDiskCacheProtocol {
    var cache: [String: UIImage] = [:]

    init(){}
    
    init(cache: [String : UIImage]) {
        self.cache = cache
    }
    
    func getImage(id: String) async -> UIImage? {
        if let image = cache[id] {
            return image
        }
        return nil
    }
    
    func saveImage(id: String, image: UIImage) async {
        cache[id] = image
    }
    
    func deleteImage(id: String) async {
        cache[id] = nil
    }
    
    func deleteCache() async {
        cache.removeAll()
    }
}
