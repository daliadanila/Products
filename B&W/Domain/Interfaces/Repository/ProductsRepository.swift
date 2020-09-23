//
//  ProductsRepository.swift
//  B&W
//
//  Created by Dalia on 17/09/2020.
//  Copyright © 2020 Artemis Simple Solutions Ltd. All rights reserved.
//

import Foundation

protocol ProductsRepository {
    func fetchProductsList(query: ProductQuery,
                           completion: @escaping (Result<Products, Error>) -> Void) -> Cancellable?
}
