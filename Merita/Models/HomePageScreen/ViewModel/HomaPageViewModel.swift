//
//  FViewModel.swift
//  Merita
//
//  Created by ahmed rabie on 01/07/2022.
//

import Foundation
/*
 class HomeViewModel--- {
 var dataArray---: [ModelOfOne---]? {
 didSet {
 bindingData(dataArray,nil)
 }
 }
 var error: Error? {
 didSet {
 bindingData(nil, error)
 }
 }
 let apiService: ApiServiceOne--- // create api service object
 var bindingData: (([ModelOfOne---]?,Error?) -> Void) = {_, _ in }
 init(apiService: ApiServiceOne--- = NetworkManagerOne()) {
 self.apiService = apiService
 }
 func fetchData() {
 apiService.fetchDataOne---() { variableXs---, error in
 if let variableXs--- = variableXs--- {
 self.dataArray--- = variableXs---
 }
 if let error = error {
 self.error = error
 }
 }
 }
 }
 */


class HomePageViewModel: HomePageProtocol {
    
    
    
    var brandsArray: [SmartCollection]? {
        didSet {
            bindingData(brandsArray,nil)
        }
    }
    var error: Error? {
        didSet {
            bindingData(nil, error)
        }
    }
    
    var categoriesArray: [CustomCollection]?{
        didSet{
            bindingCategory(categoriesArray,nil)
        }
    }
    
    var errorFetchCategory: Error?{
        didSet{
            bindingCategory(nil,errorFetchCategory)
        }
    }
    
    let apiService: ApiService
    var bindingCategory: (([CustomCollection]?, Error?) -> Void) = {_,_ in}
    var bindingData: (([SmartCollection]?,Error?) -> Void) = {_, _ in }
    init(apiService: ApiService = NetworkManager()) {
        self.apiService = apiService
    }
    
    //MARK: - Fetch Categories
    
    func fetchCategories() {
        apiService.fetchCategory { categories, error in
            if let categories = categories {
                self.categoriesArray = categories
            }
            if let error = error {
                self.errorFetchCategory = error
            }
        }
    }
    
    
    //MARK: - fetch Brands
    
    func fetchBrands() {
        apiService.fetchBrands { brands, error in
            if let brands = brands {
                self.brandsArray = brands
            }
            if let error = error {
                self.error = error
            }
        }
    }
    
}


