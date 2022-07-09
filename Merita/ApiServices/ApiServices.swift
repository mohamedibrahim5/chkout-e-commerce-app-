//
//  ApiServices.swift
//  Merita
//
//  Created by ahmed rabie on 01/07/2022.
//

import Foundation
/*
protocol ApiServiceOne{
    func fetchDataOne---(completion: @escaping (([modelOfOne---]? , Error?) -> Void) )
  
}
protocol ApiServiceTwo{
    func fetchdataTwo---(completion: @escaping (([modelOfTwo---]? , Error?) -> Void) )
  
}
*/

protocol productInfoApiServices {
    func fetchData (endPoint:String ,endPointId:String ,completion : @escaping ((Product?,Error?) -> Void))
}


protocol ApiService {
    func fetchBrands (completion: @escaping ([SmartCollection]?,Error?) -> Void)
    func fetchCategory (completion: @escaping ([CustomCollection]?,Error?) -> Void)
    func fetchProductCategory (completion: @escaping ([ProductCategory]?,Error?) -> Void)
    
}
