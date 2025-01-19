//
//  ImageLoaderTests.swift
//  RecipeWizardTests
//
//  Created by Daniel Colman on 1/18/25.
//

import Testing
@testable import RecipeWizard

struct ImageLoaderTests {
    let sut: ImageLoader
    
    init() {
        sut = ImageLoader(diskCache: MockImageDiskCache())
    }
    
//    @Test func  () async throws {
//        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
//    }

}
