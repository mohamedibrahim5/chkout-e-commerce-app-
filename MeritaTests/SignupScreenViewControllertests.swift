//
//  SignupScreenViewControllertests.swift
//  MeritaTests
//
//  Created by mohamed ibrahim on 19/07/2022.
//

import XCTest
@testable import Merita
class SignupScreenViewControllertests: XCTestCase {
    let signUp = SignupScreenViewController()
    let fav = FavouriteScreenViewController()
    
    
//    override func setUp() async throws {
//        <#code#>
//    }
//    override func tearDown() async throws {
//        <#code#>
//    }
//
//    func testcheckEmpty() {
//
//    }
    func testispass() {
        let result = signUp.isPasswordValid("moha2")
        XCTAssert(result == false)
    }
    func testStrongpass() {
        let result = signUp.isPasswordValidMoreComplites("mohamed")
        XCTAssert(result == false)
    }
    

}

