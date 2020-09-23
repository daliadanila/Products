//
//  DependencyContainer.swift
//  B&W
//
//  Created by Dalia on 18/09/2020.
//  Copyright © 2020 Artemis Simple Solutions Ltd. All rights reserved.
//

import Foundation
import UIKit

final class DependencyContainer {

    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    // MARK: - Use Cases

    func makeGetProductsUseCase() -> GetProductsUseCase {
        return DefaultGetProductsUseCase(productsRepository: makeProductsRepository())
    }

    // MARK: - Repositories

    func makeProductsRepository() -> ProductsRepository {
        return DefaultProductsRepository(dataTransferService: dependencies.apiDataTransferService)
    }

    func makeImageRepository() -> ImagesRepository {
        return DefaultImagesRepository(dataTransferService: dependencies.apiDataTransferService)
    }

    // MARK: - Controllers

    func makeProductsListViewController(actions: ProductsListViewModelActions) -> ProductsListViewController {
        return ProductsListViewController.create(with: makeProductsListViewModel(actions: actions), imagesRepository: makeImageRepository())
    }

    func makeProductsListViewModel(actions: ProductsListViewModelActions) -> ProductsListViewModel {
        return DefaultProductsListViewModel(useCase: makeGetProductsUseCase(),
                                          actions: actions)
    }

    func makeProductDetailsViewController(product: Product) -> ProductDetailsViewController {

        return ProductDetailsViewController.create(with: makeProductDetailsViewModel(product: product))
    }

    func makeProductDetailsViewModel(product: Product) -> ProductDetailsViewModel {
        return DefaultProductDetailsViewModel(product: product, imagesRepository: makeImageRepository())
    }

    // MARK: - Flow Coordinators
    func makeGetProductsFlowCoordinator(navigationController: UINavigationController) -> GetProductsFlowCoordinator {
        return GetProductsFlowCoordinator(navigationController: navigationController,
                                          dependencies: self)
    }
}

extension DependencyContainer: GetProductsFlowCoordinatorDependencies {}
