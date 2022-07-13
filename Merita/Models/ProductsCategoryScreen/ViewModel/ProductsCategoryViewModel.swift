//
//  ViewModelSec.swift
//  Merita
//
//  Created by ahmed rabie on 01/07/2022.
//

import Foundation

class ProductsCategoryViewModel: ProductCategoryProtocol{
    
    var arrayProductCategory: [ProductCategory]?{
        didSet{
            bindingProductCategory(arrayProductCategory,nil)
        }
    }
    
    var error: Error?{
        didSet{
            bindingProductCategory(nil, error)
        }
    }
    
    var bindingProductCategory: ([ProductCategory]?,Error?) -> Void = {_,_ in}
    
    let apiService: ApiService
    
    init(apiService: ApiService = NetworkManager()) {
        self.apiService = apiService
    }
    
    func fetchProductCategory() {
        apiService.fetchProductCategory { productsCategory, error in
            if let productsCategory = productsCategory {
                self.arrayProductCategory = productsCategory
            }
            if let error = error {
                self.error = error
            }
        }
    }
    
    
}
