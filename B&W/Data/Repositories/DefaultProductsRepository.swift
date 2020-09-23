//
//  DefaultProductsRepository.swift
//  B&W
//
//  Created by Dalia on 17/09/2020.
//  Copyright © 2020 Artemis Simple Solutions Ltd. All rights reserved.
//

import Foundation

final class DefaultProductsRepository {

    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultProductsRepository: ProductsRepository {

    public func fetchProductsList(query: ProductQuery,
                                completion: @escaping (Result<Products, Error>) -> Void) -> Cancellable? {

        let task = RepositoryTask()

        guard !task.isCancelled else { return nil}

        let endpoint = APIEndpoints.getProducts()
        task.networkTask = self.dataTransferService.request(with: endpoint) { result in
            switch result {
            case .success(let responseDTO):
                completion(.success(responseDTO.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return task
    }
}
