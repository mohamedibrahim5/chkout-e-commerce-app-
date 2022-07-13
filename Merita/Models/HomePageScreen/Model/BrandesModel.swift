//
//  FModel.swift
//  Merita
//
//  Created by ahmed rabie on 01/07/2022.
//
//   let smartCollections = try? newJSONDecoder().decode(SmartCollections.self, from: jsonData)

import Foundation

struct SmartCollections: Codable {
    var smart_collections: [SmartCollection]?

   
}

// MARK: - SmartCollection
struct SmartCollection: Codable {
    var id: Int?
    var handle, title: String?
    var updatedAt: Date?
    var bodyHTML: String?
    var publishedAt: Date?
    var sortOrder: SortOrder?
    var templateSuffix: JSONNull?
    var disjunctive: Bool?
    var rules: [Rule]?
    var publishedScope: PublishedScope?
    var adminGraphqlAPIID: String?
    var image: ImageForBrands?

    enum CodingKeys: String, CodingKey {
        case id, handle, title
        case updatedAt
        case bodyHTML
        case publishedAt
        case sortOrder
        case templateSuffix
        case disjunctive, rules
        case publishedScope
        case adminGraphqlAPIID
        case image
    }
}

// MARK: - Image
struct ImageForBrands: Codable {
    var createdAt: Date?
    var alt: JSONNull?
    var width, height: Int?
    var src: String?

    enum CodingKeys: String, CodingKey {
        case createdAt
        case alt, width, height, src
    }
}

enum PublishedScope: String, Codable {
    case web = "web"
}

// MARK: - Rule
struct Rule: Codable {
    var column: Column?
    var relation: Relation?
    var condition: String?
}

enum Column: String, Codable {
    case title = "title"
}

enum Relation: String, Codable {
    case contains = "contains"
}

enum SortOrder: String, Codable {
    case bestSelling = "best-selling"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
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



//
//struct SmartCollections1 : Codable{
//    let smart_collections : [SmartCollection]
//}
//
//
//// MARK: - SmartCollections
//struct SmartCollections: Codable {
//    let smartCollections: [SmartCollection]
//
//    enum CodingKeys: String, CodingKey {
//        case smartCollections = "smart_collections"
//    }
//}
//
//// MARK: - SmartCollection
//struct SmartCollection: Codable {
//    let id: Int
//    let handle, title: String
//    let updatedAt: Date
//    let bodyHTML: String
//    let publishedAt: Date
//    let sortOrder: SortOrder
//
//    let disjunctive: Bool
//    let rules: [Rule]
//    let publishedScope: PublishedScope
//    let adminGraphqlAPIID: String
//    let image: ImageForBrand
//
//    enum CodingKeys: String, CodingKey {
//        case id, handle, title
//        case updatedAt = "updated_at"
//        case bodyHTML = "body_html"
//        case publishedAt = "published_at"
//        case sortOrder = "sort_order"
//
//        case disjunctive, rules
//        case publishedScope = "published_scope"
//        case adminGraphqlAPIID = "admin_graphql_api_id"
//        case image
//    }
//}
//
//// MARK: - Image
//struct ImageForBrand: Codable {
//    let createdAt: Date
//    let width, height: Int
//    let src: String
//
//    enum CodingKeys: String, CodingKey {
//        case createdAt = "created_at"
//        case width, height, src
//    }
//}
//
//enum PublishedScope: String, Codable {
//    case web = "web"
//}
//
//// MARK: - Rule
//struct Rule: Codable {
//    let column: Column
//    let relation: Relation
//    let condition: String
//}
//
//enum Column: String, Codable {
//    case title = "title"
//}
//
//enum Relation: String, Codable {
//    case contains = "contains"
//}
//
//enum SortOrder: String, Codable {
//    case bestSelling = "best-selling"
//}
//
//
//// MARK: - Encode/decode helpers
//
//
