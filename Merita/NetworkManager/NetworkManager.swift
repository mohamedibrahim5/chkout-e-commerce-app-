//
//  NetworkManager.swift
//  Merita
//
//  Created by ahmed rabie on 01/07/2022.
//

import Foundation
import Alamofire

//class NetworkManagerOne: ApiServiceOne--- {


/*
 func fetchDataOne---(completion: @escaping (([ModelOfOne---]?, Error?) -> Void)) {
 let endPoint = EndPoint.a---.rawValue
 if let url = URL(string: urlServices(endPoint: endPoint).url){
 URLSession.shared.dataTask(with: url) { data , response , error in
 if let data = data {
 let decodedArray: NameOfStructOfModelOne---! = convertFromJson(data: data)
 completion(decodedArray.NameOfStructOfModelOne---, nil)
 
 }
 if let error = error {
 print(error.localizedDescription)
 }
 }.resume()
 
 }
 }
 }
 */


/*
 class NetworkManagerTwo: ApiServiceTwo{
 
 func fetchDataTwo---(completion: @escaping (([ModelOfTwo---]?, Error?) -> Void)) {
 let endPoint = EndPoint.b---.rawValue
 if let url = URL(string: urlServices(endPoint: endPoint).url){
 URLSession.shared.dataTask(with: url) { data , response , error in
 if let data = data {
 let decodedArray: NameOfStructOfModelTwo---! = convertFromJson(data: data)
 completion(decodedArray.NameOfStructOfModelTwo---, nil)
 
 }
 if let error = error {
 print(error.localizedDescription)
 }
 }.resume()
 
 }
 }
 }
 }
 */
// and we continue on this 


class ProductInfoNetworkManager: productInfoApiServices {
    func fetchData(endPoint:String ,endPointId:String ,completion: @escaping ((Product?, Error?) -> Void)) {
        if let  url = URL(string: "https://7d67dd63dc90e18fce08d1f7746e9f41:shpat_8e5e99a392f4a8e210bd6c4261b93 50e@ios-q3-mansoura.myshopify.com/admin/api/2022-01/products/7730623709398.json") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let decodedArray:ProductDetailes! = convertFromJson(data: data)
                    completion(decodedArray.product,nil)
                }
                if let error = error {
                    completion(nil, error)
                }
            }.resume()
        }
    }
}

class NetworkManager: ApiService {
    
    
    
    //MARK: - Fetch Product Category
    func fetchProductCategory(completion: @escaping ([ProductCategory]?, Error?) -> Void) {
        let endPoint = EndPointForUrl.productCategory.rawValue
        if let url = URL(string: urlServices(endPoint: endPoint).urlForProductsCategory){
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    var arrayOfProductCategory = [ProductCategory]()
                    
                    let arrayDecoded: ProductsCategory? = convertFromJson(data: data)
                    arrayOfProductCategory = arrayDecoded?.products ?? []
                    print(url)
                    completion(arrayOfProductCategory, nil)
                }
                if let error = error {
                    completion(nil, error)
                }
            }.resume()
        }
    }
    
    
    //MARK: - Fetch Categories
    func fetchCategory(completion: @escaping ([CustomCollection]?, Error?) -> Void) {
        
        let endPoint = EndPointForUrl.customCollectionsInApi.rawValue
      

        if let url = URL(string: urlServices(endPoint: endPoint).urlForCategory){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    var arrayOfCategory = [CustomCollection]()
                    
                    let arrayDecoded : CustomCollections? = convertFromJson(data: data)
                    arrayOfCategory = arrayDecoded?.custom_collections ?? []
                    print(url)
                    print(arrayOfCategory)
                    completion(arrayOfCategory,nil)
                }
                if let error = error{
                    completion(nil,error)
                }
            }.resume()
        }
    }
    
    
    
    
    
    //MARK: - Fetch Brands
    func fetchBrands(completion: @escaping ([SmartCollection]?, Error?) -> Void) {
        let endPoint = EndPointForUrl.smartCollectionsInApi.rawValue
      
        if let url = URL(string: urlServices(endPoint: endPoint).urlForBrands){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    var arrayOfBrand = [SmartCollection]()
                    
                    let arrayDecoded : SmartCollections? = convertFromJson(data: data)
                    arrayOfBrand = arrayDecoded?.smart_collections ?? []
                   // print(url)
                   // print(arrayDecoded )
                    completion(arrayOfBrand,nil)
                }
                if let error = error{
                    completion(nil,error)
                }
            }.resume()
        }
        
//        AF.request(urlServices(endPoint: endPoint).urlForBrandes).response { smartCollection in
//            if let smartCollection = smartCollection.data {
//                var arrayOfBrand = [SmartCollection]()
//
//                let arrayDecoded: SmartCollections1? = convertFromJson(data: smartCollection)
//
//                arrayOfBrand = arrayDecoded?.smart_collections ?? []
//                print(url)
//                print(arrayDecoded)
//                //print("I print in network manager \(arrayOfBrand[0].title )")
//                completion(arrayOfBrand,nil)
//            }
//            if let error = smartCollection.error{
//                completion(nil,error)
//            }
//        }
    }
}



//MARK: - EndPoints

enum EndPointForUrl: String {
    case smartCollectionsInApi = "smart_collections"
    case customCollectionsInApi = "custom_collections"
    case productCategory = "products"
}




