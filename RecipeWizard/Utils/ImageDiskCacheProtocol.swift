//
//  ImageDiskCacheProtocol.swift
//  RecipeWizard
//
//  Created by Daniel Colman on 1/18/25.
//

import UIKit

protocol ImageDiskCacheProtocol {
    func getImage(id: String) async -> UIImage?
    func saveImage(id: String, image: UIImage) async
    func deleteImage(id: String) async
    func deleteCache() async
}
