//
//  MockURLSession.swift
//  RecipeWizard
//
//  Created by Daniel Colman on 1/19/25.
//

import Foundation
@testable import RecipeWizard
import UIKit

let imageData = UIImage(named: "cake")!.pngData()!
let successResponse = HTTPURLResponse(url: URL(string: "URL")!,
                               statusCode: 200,
                               httpVersion: nil,
                               headerFields: nil)!
let failureResponse = HTTPURLResponse(url: URL(string: "URL")!,
                               statusCode: 500,
                               httpVersion: nil,
                               headerFields: nil)!


class MockURLSession: URLSessionProtocol {
    func data(from url: URL, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        return (imageData, successResponse)
    }
}

class MockURLSessionThrows: URLSessionProtocol {
    func data(from url: URL, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        throw URLError(.badURL)
    }
}

class MockURLSessionNon200: URLSessionProtocol {
    func data(from url: URL, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        return (Data(), failureResponse)
    }
}

class MockURLSessionBadData: URLSessionProtocol {
    func data(from url: URL, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        return (Data(), successResponse)
    }
}
