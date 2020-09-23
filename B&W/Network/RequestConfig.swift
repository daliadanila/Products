//
//  RequestConfig.swift
//  B&W
//
//  Created by Dalia on 17/09/2020.
//  Copyright © 2020 Artemis Simple Solutions Ltd. All rights reserved.
//

import Foundation

public protocol RequestConfig {
    var baseURL: URL { get }
}

public struct ApiRequestConfig: RequestConfig {
    public let baseURL: URL

     public init(baseURL: URL) {
        self.baseURL = baseURL
    }
}
