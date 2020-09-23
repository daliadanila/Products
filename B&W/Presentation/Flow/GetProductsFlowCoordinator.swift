//
//  GetProductsFlowCoordinator.swift
//  B&W
//
//  Created by Dalia on 18/09/2020.
//  Copyright © 2020 Artemis Simple Solutions Ltd. All rights reserved.
//

import UIKit

protocol GetProductsFlowCoordinatorDependencies {
    func makeProductsListViewController(actions: ProductsListViewModelActions) -> ProductsListViewController
    func makeProductDetailsViewController(product: Product) -> ProductDetailsViewController
}

final class GetProductsFlowCoordinator {

    private weak var navigationController: UINavigationController?
    private let dependencies: GetProductsFlowCoordinatorDependencies

    private weak var productsListVC: ProductsListViewController?

    init(navigationController: UINavigationController,
         dependencies: GetProductsFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
        let actions = ProductsListViewModelActions(showProductDetails: showProductDetails)
        let vc = dependencies.makeProductsListViewController(actions: actions)

        navigationController?.pushViewController(vc, animated: false)
        productsListVC = vc
    }

    private func showProductDetails(product: Product) {
        let vc = dependencies.makeProductDetailsViewController(product: product)
        navigationController?.pushViewController(vc, animated: true)
    }
}
