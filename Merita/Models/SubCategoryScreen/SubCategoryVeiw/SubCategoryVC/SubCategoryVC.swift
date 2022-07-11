//
//  SubCategoryVC.swift
//  Merita
//
//  Created by Abo Saleh on 11/07/2022.
//

import UIKit

class SubCategoryVC: UIViewController {
    
    
    @IBOutlet weak var shoesBtnOutlet: UIButton!
    
    var passShoesCategoryDelegate: SubCategoryProductsProtocol?
    
    var arrayOfSubCategory = [ProductCategory]()
    
    var arrayOfAllProducts = [ProductCategory]()
    
    var titleButton = ""
    
    let productCategoryViewModel = ProductsCategoryViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productCategoryViewModel.fetchProductCategory()
        productCategoryViewModel.bindingProductCategory = { allProducts, error in
            if let allProducts = allProducts {
                self.arrayOfAllProducts = allProducts
                DispatchQueue.main.async {
                    
                }
                if let error = error{
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
    @IBAction func shoesBtnAction(_ sender: UIButton) {
        
        let buttonShoesTitle = shoesBtnOutlet?.titleLabel?.text
        getSubCategory(arrayOfAllProducts: arrayOfAllProducts, productType: buttonShoesTitle)
    }
    
    @IBAction func accessoriesBtnAction(_ sender: UIButton) {
        
        let buttonAccessoriesTitle = sender.titleLabel?.text
        getSubCategory(arrayOfAllProducts: arrayOfAllProducts, productType: buttonAccessoriesTitle)
        
    }
    
    @IBAction func tshirtBtnAction(_ sender: UIButton) {
        let buttonTshirtTitle = sender.titleLabel?.text
        getSubCategory(arrayOfAllProducts: arrayOfAllProducts, productType: buttonTshirtTitle)
        
    }
    
    
    @IBAction func allProductBtn(_ sender: UIButton) {
        
        if let passShoesCategoryDelegate = passShoesCategoryDelegate {
            passShoesCategoryDelegate.setSubCategory(subCategory: arrayOfAllProducts)
        }
        
        dismissSubCategoryVc()
    }
    
    
    
    @IBAction func dismissBtn(_ sender: UIButton) {
        dismissSubCategoryVc()
        print("Pressed")
    }
    
    
    @IBAction func dismissBtnInView(_ sender: UIButton) {
        print("Pressed Button inView")
    }
    
    
    
    func getSubCategory(arrayOfAllProducts: [ProductCategory], productType: String?) {
        if let productType = productType {
            for product in arrayOfAllProducts {
                if let product_Type = product.product_type{
                    if product_Type == productType{
                        arrayOfSubCategory.append(product)
                    }
                }
            }
        }
        
        if let passShoesCategoryDelegate = passShoesCategoryDelegate {
            passShoesCategoryDelegate.setSubCategory(subCategory: arrayOfSubCategory)
        }
        
        dismissSubCategoryVc()
        
    }
    
    
    func dismissSubCategoryVc(){
        dismiss(animated: true)
    }
}


