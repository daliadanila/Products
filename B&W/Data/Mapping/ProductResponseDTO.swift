//
//  ProductResponseDTO.swift
//  B&W
//
//  Created by Dalia on 17/09/2020.
//  Copyright © 2020 Artemis Simple Solutions Ltd. All rights reserved.
//

import Foundation

struct ProductResponseDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case products = "data"
    }
    let products: [ProductDTO]
}

extension ProductResponseDTO {
    struct ProductDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case id
            case attributes
        }
        let id: String
        let attributes: ProductAttributesDTO

    }

    struct ProductAttributesDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case name
            case description
            case priceData = "price_data"
            case media
        }

        let name: String?
        let description: String?
        let priceData: [ProductPriceDTO]?
        let media: [ProductMediaDTO]?
    }

    struct ProductPriceDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case price = "price_pennies"
        }

        let price: Int?
    }

    struct ProductMediaDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case url
        }

        let url: String?
    }
}

// MARK: - Mappings to Domain

extension ProductResponseDTO {
    func toDomain() -> Products {
        return .init(products: products.map { $0.toDomain() })
    }
}

extension ProductResponseDTO.ProductDTO {
    func toDomain() -> Product {
        let priceString = "£" + String(format: "%.2f", Double(((attributes.priceData?.first?.price) ?? 0) / 100))

        return .init(id: Product.Identifier(id),
                     name: attributes.name,
                     description: attributes.description,
                     price: priceString,
                     imagePath: attributes.media?.first?.url)
    }
}
