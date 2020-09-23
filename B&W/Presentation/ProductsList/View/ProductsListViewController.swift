//
//  ProductsListViewController.swift
//  B&W
//
//  Created by Dalia on 17/09/2020.
//  Copyright © 2020 Artemis Simple Solutions Ltd. All rights reserved.
//

import UIKit

class ProductsListViewController: UITableViewController, StoryboardInstantiable {

    var viewModel: ProductsListViewModel!

    var imagesRepository: ImagesRepository?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }

    private func bind(to viewModel: ProductsListViewModel) {
        viewModel.items.observe(on: self) { [weak self] _ in self?.tableView.reloadData() }
        viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
    }

    private func showError(_ error: String) {
        guard !error.isEmpty else { return }

        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    static func create(with viewModel: ProductsListViewModel, imagesRepository: ImagesRepository?) -> ProductsListViewController {
        let view = ProductsListViewController.instantiateViewController()
        view.viewModel = viewModel
        view.imagesRepository = imagesRepository
        return view
    }

}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ProductsListViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductListItemCell.reuseIdentifier,
                                                       for: indexPath) as? ProductListItemCell else {
            assertionFailure("Cannot dequeue reusable cell \(ProductListItemCell.self) with reuseIdentifier: \(ProductListItemCell.reuseIdentifier)")
            return UITableViewCell()
        }

        cell.fill(with: viewModel.items.value[indexPath.row], imagesRepository: imagesRepository)

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ProductListItemCell.height
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath.row)
    }
}
