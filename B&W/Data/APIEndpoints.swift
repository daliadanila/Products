//
//  APIEndpoints.swift
//  B&W
//
//  Created by Dalia on 17/09/2020.
//  Copyright © 2020 Artemis Simple Solutions Ltd. All rights reserved.
//

import Foundation

struct APIEndpoints {

    static func getProducts() -> Endpoint<ProductResponseDTO> {
        return Endpoint(path: "db",
                        method: .get)
    }

    static func getProductImage(path: String) -> Endpoint<Data> {
        return Endpoint(path: path,
                        isFullPath: true,
                        method: .get,
                        responseDecoder: RawDataResponseDecoder())
    }
}
