//
//  Endpoint.swift
//  B&W
//
//  Created by Dalia on 17/09/2020.
//  Copyright © 2020 Artemis Simple Solutions Ltd. All rights reserved.
//

import Foundation

public enum HTTPMethodType: String {
    case get     = "GET"
    case post    = "POST"
    // etc
}

public class Endpoint<R>: ResponseRequestable {

    public typealias Response = R

    public var path: String
    public var isFullPath: Bool
    public var method: HTTPMethodType
    public var responseDecoder: ResponseDecoder

    init(path: String,
         isFullPath: Bool = false,
         method: HTTPMethodType,
         responseDecoder: ResponseDecoder = JSONResponseDecoder()) {
        self.path = path
        self.isFullPath = isFullPath
        self.method = method
        self.responseDecoder = responseDecoder
    }
}

public protocol Requestable {
    var path: String { get }
    var isFullPath: Bool { get }
    var method: HTTPMethodType { get }

    func urlRequest(with config: RequestConfig) throws -> URLRequest
}

public protocol ResponseRequestable: Requestable {
    associatedtype Response

    var responseDecoder: ResponseDecoder { get }
}

enum RequestError: Error {
    case componentsError
}

extension Requestable {
    func url(with config: RequestConfig) throws -> URL {

        let baseURL = config.baseURL.absoluteString.last != "/" ? config.baseURL.absoluteString + "/" : config.baseURL.absoluteString
        let endpoint = isFullPath ? path : baseURL.appending(path)

        guard let urlComponents = URLComponents(string: endpoint) else { throw RequestError.componentsError }

        guard let url = urlComponents.url else { throw RequestError.componentsError }

        return url
    }

    public func urlRequest(with config: RequestConfig) throws -> URLRequest {

        let url = try self.url(with: config)
        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}

public protocol ResponseDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

// MARK: - Response Decoders
public class JSONResponseDecoder: ResponseDecoder {
    private let jsonDecoder = JSONDecoder()
    public init() { }
    public func decode<T: Decodable>(_ data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
}
