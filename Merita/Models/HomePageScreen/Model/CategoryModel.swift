//
//  CategoryModel.swift
//  Merita
//
//  Created by Abo Saleh on 05/07/2022.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let categoryCollections = try? newJSONDecoder().decode(CustomCollections.self, from: jsonData)



import Foundation

struct CustomCollections: Codable{
    var custom_collections: [CustomCollection]
}


struct CustomCollection: Codable{
    var id: Int
    var handle, title: String?
    var body_html: String?
    var sort_order: String?
    var image: imageForCategory?
}

struct imageForCategory: Codable{
    var width, height: Int?
    var src: String?
}

/*
struct CustomCollections: Codable {
    var custom_collections: [CustomCollection]?

   
}

// MARK: - SmartCollection
struct CustomCollection: Codable {
    var id: Int?
    var handle, title: String?
    var updatedAt: Date?
    var bodyHTML: String?
    var publishedAt: Date?
    var sortOrder: String?
    var templateSuffix: JSONNull?
    var publishedScope: String?
    var adminGraphqlAPIID: String?
    var image: ImageCategory?

    enum CodingKeys: String, CodingKey {
        case id, handle, title
        case updatedAt
        case bodyHTML
        case publishedAt
        case sortOrder
        case templateSuffix
        case publishedScope
        case adminGraphqlAPIID
        case image
    }
}

// MARK: - Image
struct ImageCategory: Codable {
    var createdAt: Date?
    var alt: JSONNull?
    var width, height: Int?
    var src: String?

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case alt, width, height, src
    }
}


*/
// MARK: - Encode/decode helpers






/*
// MARK: - CategoryCollections
struct CustomCollections: Codable {
    var custom_Collections: [CustomCollection]?

    
}

// MARK: - CustomCollection
struct CustomCollection: Codable {
    let id: Int
    let handle, title: String
    let updatedAt: Date
    let bodyHTML: String?
    let publishedAt: Date
    let sortOrder: String
    let templateSuffix: JSONNullForCategory?
    let publishedScope, adminGraphqlAPIID: String
    let image: ImageCategory?

    enum CodingKeys: String, CodingKey {
        case id, handle, title
        case updatedAt = "updated_at"
        case bodyHTML = "body_html"
        case publishedAt = "published_at"
        case sortOrder = "sort_order"
        case templateSuffix = "template_suffix"
        case publishedScope = "published_scope"
        case adminGraphqlAPIID = "admin_graphql_api_id"
        case image
    }
}

// MARK: - Image
struct ImageCategory: Codable {
    let createdAt: Date
    let alt: JSONNull?
    let width, height: Int
    let src: String

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case alt, width, height, src
    }
}

// MARK: - Encode/decode helpers

class JSONNullForCategory: Codable, Hashable {

    public static func == (lhs: JSONNullForCategory, rhs: JSONNullForCategory) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
    
}
    
*/
