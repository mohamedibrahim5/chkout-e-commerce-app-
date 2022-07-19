//
//  NetworkManagerTests.swift
//  MeritaTests
//
//  Created by Abo Saleh on 19/07/2022.
//

import XCTest
@testable import Merita

class NetworkManagerTests: XCTestCase {

    var apiService: ApiService!
    
    override func setUp() {
        apiService = NetworkMangerMock(shouldReturnError: true)
    }
    
    override func tearDown() {
        apiService = nil
        
    }
    
    
    func testFetchMockingBrands(){
        apiService.fetchBrands { brands, error in
            XCTAssertNil(brands)
        }
    }
    
    
    func testFetchMockingCategory(){
        apiService.fetchCategory { categories, error in
            XCTAssertNil(categories)
        }
    }
    
    
    func testFetchMockingProducts(){
        apiService.fetchProductCategory { products, error in
            XCTAssertNil(products)
        }
    }
    

}
