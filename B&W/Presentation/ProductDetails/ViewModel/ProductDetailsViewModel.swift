//
//  ProductDetailsViewModel.swift
//  B&W
//
//  Created by Dalia on 19/09/2020.
//  Copyright © 2020 Artemis Simple Solutions Ltd. All rights reserved.
//

import Foundation

protocol ProductDetailsViewModelInput {
    func updateImage()
}

protocol ProductDetailsViewModelOutput {
    var name: String { get }
    var image: Observable<Data?> { get }
    var description: String { get }
    var price: String { get }
}

protocol ProductDetailsViewModel: ProductDetailsViewModelInput, ProductDetailsViewModelOutput { }

final class DefaultProductDetailsViewModel: ProductDetailsViewModel {

    private let imagePath: String?
    private let imagesRepository: ImagesRepository
    private var imageLoadTask: Cancellable? { willSet { imageLoadTask?.cancel() } }

    let name: String
    let image: Observable<Data?> = Observable(nil)
    let description: String
    let price: String

    init(product: Product, imagesRepository: ImagesRepository) {
        self.name = product.name ?? ""
        self.description = product.description ?? ""
        self.imagePath = product.imagePath
        self.price = product.price ?? ""
        self.imagesRepository = imagesRepository
    }
}

extension DefaultProductDetailsViewModel {
    func updateImage() {
        guard let imagePath = imagePath else { return }

        imageLoadTask = imagesRepository.fetchImage(with: imagePath) { result in
            guard self.imagePath == imagePath else { return }
            switch result {
            case .success(let data):
                self.image.value = data
            case .failure: break
            }
            self.imageLoadTask = nil
        }
    }
}
