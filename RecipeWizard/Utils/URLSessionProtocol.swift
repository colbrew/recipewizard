//
//  URLSessionProtocol.swift
//  RecipeWizard
//
//  Created by Daniel Colman on 1/19/25.
//

import Foundation

protocol URLSessionProtocol {
    func data(from url: URL, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
