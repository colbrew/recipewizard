//
//  MockURLSession.swift
//  RecipeWizard
//
//  Created by Daniel Colman on 1/19/25.
//

import Foundation
@testable import RecipeWizard

class MockURLSession: URLSessionProtocol {
    func data(from url: URL, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        return (Data(), URLResponse())
    }
}
    
