//
//  ProductDetailsViewController.swift
//  B&W
//
//  Created by Dalia on 17/09/2020.
//  Copyright © 2020 Artemis Simple Solutions Ltd. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController, StoryboardInstantiable {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDescriptionTextView: UITextView!

    private var viewModel: ProductDetailsViewModel!

    static func create(with viewModel: ProductDetailsViewModel) -> ProductDetailsViewController {
        let view = ProductDetailsViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind(to: viewModel)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewModel.updateImage()
    }

    private func bind(to viewModel: ProductDetailsViewModel) {
        viewModel.image.observe(on: self) { [weak self] in
            self?.productImageView.image = $0.flatMap(UIImage.init) }
    }

    private func setupViews() {
        title = viewModel.name
        productPriceLabel.text = viewModel.price
        productDescriptionTextView.text = viewModel.description

    }
}
