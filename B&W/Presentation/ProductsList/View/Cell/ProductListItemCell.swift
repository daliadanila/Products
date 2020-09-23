//
//  ProductListItemCell.swift
//  B&W
//
//  Created by Dalia on 17/09/2020.
//  Copyright © 2020 Artemis Simple Solutions Ltd. All rights reserved.
//

import UIKit

final class ProductListItemCell: UITableViewCell {

    static let reuseIdentifier = String(describing: ProductListItemCell.self)
    static let height = CGFloat(140)

    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var priceLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var productImageView: UIImageView!

    private var viewModel: ProductsListItemViewModel!

    private var imagesRepository: ImagesRepository?
    private var imageLoadTask: Cancellable? { willSet { imageLoadTask?.cancel() } }

    func fill(with viewModel: ProductsListItemViewModel, imagesRepository: ImagesRepository?) {
        self.viewModel = viewModel
        self.imagesRepository = imagesRepository

        nameLabel.text = viewModel.name
        priceLabel.text = viewModel.price.description
        descriptionLabel.text = viewModel.description
        updateImage()
    }

    private func updateImage() {
        productImageView.image = nil

        imageLoadTask = imagesRepository?.fetchImage(with: viewModel.imagePath) { [weak self] result in
            guard let self = self else { return }
            if case let .success(data) = result {
                self.productImageView.image = UIImage(data: data)
            }
            self.imageLoadTask = nil
        }
    }
}
