//
//  DiscountProduct.swift
//  KukaAppsiOSCase2
//
//  Created by Veysel Bozkurt on 6.08.2022.
//

import Foundation


// MARK: - DiscountProduct
struct DiscountProduct: Codable {
    let id: Int?
    let title: String?
    let price: Price?
}

// MARK: - Price
struct Price: Codable {
    let originalPrice: Double?
    let discountLevels: [DiscountLevel]?
}

// MARK: - DiscountLevel
struct DiscountLevel: Codable {
    let level: Int?
    let discountedPrice: Double?
}
