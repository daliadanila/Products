//
//  ProductsListViewModelTests.swift
//  B&WTests
//
//  Created by Dalia on 17/09/2020.
//  Copyright © 2020 Artemis Simple Solutions Ltd. All rights reserved.
//

import XCTest
@testable import B_W

class ProductsListViewModelTests: XCTestCase {

    let products: Products = {
        let product1 = Product.stub()
        let product2 = Product.stub()
        return Products(products: [product1, product2])
    }()

    class GetProductsUseCaseMock: GetProductsUseCase {
        var expectation: XCTestExpectation?
        var error: Error?
        var products = Products(products: [])

        func execute(requestValue: GetProductsUseCaseRequestValue,
                     completion: @escaping (Result<Products, Error>) -> Void) -> Cancellable? {
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(products))
            }
            expectation?.fulfill()
            return nil
        }
    }

    func test_whenGetProductsUseCaseRetrievesProducts_thenViewModelContainsProducts() {
        // given
        let getProductsUseCaseMock = GetProductsUseCaseMock()
        getProductsUseCaseMock.expectation = self.expectation(description: "contains products")
        getProductsUseCaseMock.products = products
        let viewModel = DefaultProductsListViewModel(useCase: getProductsUseCaseMock)
        // when
        viewModel.viewDidLoad()

        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.items.value.count, 2)
    }

}

extension Product {
    static func stub(id: Product.Identifier = "id1",
                     name: String = "Flower 1",
                     description: String = "Some description",
                     price: String = "£15.00",
                     imagePath: String? = nil) -> Self {
        Product(id: id,
                name: name,
                description: description,
                price: price,
                imagePath: imagePath)
    }
}
