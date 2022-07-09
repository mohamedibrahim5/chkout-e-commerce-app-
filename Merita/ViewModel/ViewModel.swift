//
//  ViewModel.swift
//  Merita
//
//  Created by mohamed ibrahim on 04/07/2022.
//

import Foundation

class ProductInfoViewModel {
    var productArray : Product? {
        didSet {
            bindingData(productArray,nil)
        }
    }
    var error : Error? {
        didSet {
            bindingData(nil,error)
        }
    }
    let productInfoApiServices: productInfoApiServices
    var bindingData: ((Product?,Error?) -> Void) = {_, _ in }
    
    init (productInfoApiServices:productInfoApiServices = ProductInfoNetworkManager()){
        self.productInfoApiServices = productInfoApiServices
    }
    func fetchData(endPoint:String,endPointId:String) {
        productInfoApiServices.fetchData(endPoint: endPoint, endPointId: endPointId) { productinfo, error in
            if let productinfo = productinfo {
                self.productArray = productinfo
            }
            if let error = error {
                self.error = error
            }
        }
    }
}
