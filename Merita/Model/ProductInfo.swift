//
//  ProductInfo.swift
//  Merita
//
//  Created by mohamed ibrahim on 04/07/2022.
//

import Foundation


// MARK: - ProductDetailes
struct ProductDetailes: Codable {
    var product: Product?
}

// MARK: - Product
struct Product: Codable {
    var id: Int?
    var title, bodyHTML, vendor, productType: String?
    var variants: [Variant]?
    var images: [Image]?
}

// MARK: - Image
struct Image: Codable {
    var id, productID: Int?
    var src: String?
}

// MARK: - Variant
struct Variant: Codable {
    var price: String?

}
struct ProductInfo {
    var nameOfProduct:String?
    var vendor:String?
    var price:String?
    var description:String?
    var images : [String]?
    
}
