//
//  AppFlowCoordinator.swift
//  B&W
//
//  Created by Dalia on 18/09/2020.
//  Copyright © 2020 Artemis Simple Solutions Ltd. All rights reserved.
//

import UIKit

final class AppFlowCoordinator {

    var navigationController: UINavigationController
    private let appDependencies: AppDependenciesContainer

    init(navigationController: UINavigationController,
         appDependencies: AppDependenciesContainer) {
        self.navigationController = navigationController
        self.appDependencies = appDependencies
    }

    func start() {
        let productsDependencies = appDependencies.makeProductsDependenciesContainer()
        let flow = productsDependencies.makeGetProductsFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
}

final class AppDependenciesContainer {

    lazy var apiDataTransferService: DataTransferService = {
        let config = ApiRequestConfig(baseURL: URL(string: "https://my-json-server.typicode.com/daliadanila/ProductsAPI/")!)

        let apiDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()

    func makeProductsDependenciesContainer() -> DependencyContainer {
        let dependencies = DependencyContainer.Dependencies(apiDataTransferService: apiDataTransferService)
        return DependencyContainer(dependencies: dependencies)
    }
}
