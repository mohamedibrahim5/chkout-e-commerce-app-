//
//  Model.swift
//  Merita
//
//  Created by ahmed rabie on 01/07/2022.
//


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let productsCategory = try? newJSONDecoder().decode(ProductsCategory.self, from: jsonData)

import Foundation

struct ProductsCategory : Codable {
    let products : [ProductCategory]?
}

//MARK: - ProductCategoryModel

class ProductCategory : NSObject, Codable {
    let id : Int?
    var title : String?
    let body_html : String?
    let vendor : String?
    let product_type : String?
    let created_at : String?
    let handle : String?
    let updated_at : String?
    let published_at : String?
    let template_suffix : String?
    let status : String?
    let published_scope : String?
    let tags : String?
    let admin_graphql_api_id : String?
    let variants : [VariantsProductCategory]?
    let options : [OptionsProductCategory]?
    let images : [ImagesProductCategory]?
    let image : ImageProductCategory?
}

//MARK: - OptionsProductCategory

struct OptionsProductCategory : Codable {
    let id : Int?
    let product_id : Int?
    let name : String?
    let position : Int?
    let valuesOption : [String]?

  

 

}


//MARK: - VariantsProductCategory

struct VariantsProductCategory : Codable {
    let id : Int?
    let product_id : Int?
    let title : String?
    let price : String?
    let sku : String?
    let position : Int?
    let inventory_policy : String?
    let compare_at_price : String?
    let fulfillment_service : String?
    let inventory_management : String?
    let option1 : String?
    let option2 : String?
    let option3 : String?
    let created_at : String?
    let updated_at : String?
    let taxable : Bool?
    let barcode : String?
    let grams : Int?
    let image_id : String?
    let weight : Int?
    let weight_unit : String?
    let inventory_item_id : Int?
    let inventory_quantity : Int?
    let old_inventory_quantity : Int?
    let requires_shipping : Bool?
    let admin_graphql_api_id : String?

   

 

}


//MARK: - ImagesProductCatogry

struct ImagesProductCategory : Codable {
    let id : Int?
    let product_id : Int?
    let position : Int?
    let created_at : String?
    let updated_at : String?
    let alt : String?
    let width : Int?
    let height : Int?
    let src : String?
    let variant_ids : [String]?
    let admin_graphql_api_id : String?

   


}


//MARK: - ImageProductCategoryModel

struct ImageProductCategory : Codable {
    let id : Int?
    let product_id : Int?
    let position : Int?
    let created_at : String?
    let updated_at : String?
    let alt : String?
    let width : Int?
    let height : Int?
    let src : String?
    let variant_ids : [String]?
    let admin_graphql_api_id : String?

   



}


/*
 struct ProductsCategory: Codable{
     var products: [ProductCategory]?
 }

 struct ProductCategory: Codable{
     var id: Int?
     var title: String?
     var body_html, vendor, product_type: String?
     var handle, status, tags: String?
     var variants: [VariantProductCategory]?
     var options: [OptionProductCategory]?
     var images: [ImageProductCategory]?
 }

 struct ImageProductCategory: Codable{
     var id, product_id, position, width, height: Int?
     var src: String?
 }

 struct OptionProductCategory: Codable{
     var id: Int?
     var product_id: Int?
     var name: String?
     var position: String?
     var values: [String]?
 }

 struct VariantProductCategory: Codable{
     var id: Int?
     var product_id: Int?
     var title: String?
     var price: String?
     var sku: String?
     var position: Int?
     var inventory_item_id: Int?
 }
*/
 
