//
//  URL.swift
//  Merita
//
//  Created by ahmed rabie on 01/07/2022.
//

import Foundation

struct urlServices {
    
    private let apiKey = "7d67dd63dc90e18fce08d1f7746e9f41"
    private let password = "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"
    private let hostname = "ios-q3-mansoura.myshopify.com/"
    
    
    var endPoint : String = ""
    
    
    var url: String {
      return "https://www.----\(endPoint)"
    }
    
    var urlForBrands: String{
        return "https://\(apiKey):\(password)@\(hostname)/admin/api/2022-01/\(endPoint).json"
    }
    
    var urlForCategory: String{
        return "https://\(apiKey):\(password)@\(hostname)/admin/api/2022-01/\(endPoint).json"
    }
    
    var urlForProductsCategory: String{
        return "https://\(apiKey):\(password)@\(hostname)/admin/api/2022-01/\(endPoint).json"
    }
    
    
   
}


enum EndPoint: String {
    case a = "@endPoint of view a---"
    case b = "@endPoint of view b---"
    case productInfo = "products/"
    
}


struct UrlServices {
    var endPoint = ""
    var endPointId = ""
    
    
    var url: String {
        return "https://7d67dd63dc90e18fce08d1f7746e9f41:shpat_8e5e99a392f4a8e210bd6c4261b93 50e@ios-q3-mansoura.myshopify.com/admin/api/2022-01/\(endPoint)\(endPointId).json"
    }
    
   
    
    
}


// https://7d67dd63dc90e18fce08d1f7746e9f41:shpat_8e5e99a392f4a8e210bd6c4261b93 50e@ios-q3-mansoura.myshopify.com/admin/api/2022-01/products/7730623709398.json
