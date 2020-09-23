//
//  ProductsListItemViewModel.swift
//  B&W
//
//  Created by Dalia on 17/09/2020.
//  Copyright © 2020 Artemis Simple Solutions Ltd. All rights reserved.
//

import Foundation

struct ProductsListItemViewModel: Equatable {
    let name: String
    let price: String
    let description: String
    let imagePath: String
}

extension ProductsListItemViewModel {
    init(product: Product) {
        self.name = product.name ?? ""
        self.price = product.price ?? ""
        self.description = product.description ?? ""
        self.imagePath = product.imagePath ?? ""
    }
}
