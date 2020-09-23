//
//  Product.swift
//  B&W
//
//  Created by Dalia on 17/09/2020.
//  Copyright © 2020 Artemis Simple Solutions Ltd. All rights reserved.
//

import Foundation

struct Product: Equatable, Identifiable {
    typealias Identifier = String
    let id: Identifier
    let name: String?
    let description: String?
    let price: String?
    let imagePath: String?
}

struct Products: Equatable {
    let products: [Product]
}
