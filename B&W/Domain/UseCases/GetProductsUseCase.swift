//
//  GetProductsUseCase.swift
//  B&W
//
//  Created by Dalia on 17/09/2020.
//  Copyright © 2020 Artemis Simple Solutions Ltd. All rights reserved.
//

import Foundation

protocol GetProductsUseCase {
    func execute(requestValue: GetProductsUseCaseRequestValue,
                 completion: @escaping (Result<Products, Error>) -> Void) -> Cancellable?
}

final class DefaultGetProductsUseCase: GetProductsUseCase {

    private let productsRepository: ProductsRepository

    init(productsRepository: ProductsRepository) {

        self.productsRepository = productsRepository
    }

    func execute(requestValue: GetProductsUseCaseRequestValue,
                 completion: @escaping (Result<Products, Error>) -> Void) -> Cancellable? {

        return productsRepository.fetchProductsList(query: requestValue.query,
                                                completion: { result in
            completion(result)
        })
    }
}

struct GetProductsUseCaseRequestValue {
    let query: ProductQuery
}
