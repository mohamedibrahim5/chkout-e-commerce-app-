//
//  SubCategoryVC.swift
//  Merita
//
//  Created by Abo Saleh on 11/07/2022.
//

import UIKit
import  NVActivityIndicatorView
class SubCategoryVC: UIViewController {
    let indicator = NVActivityIndicatorView(frame: .zero, type: .ballSpinFadeLoader, color: .systemRed, padding: 0)
    var userId:String?
    @IBOutlet weak var shoesBtnOutlet: UIButton!
    
    var passShoesCategoryDelegate: SubCategoryProductsProtocol?
    
    var arrayOfSubCategory = [ProductCategory]()
    
    var arrayOfAllProducts = [ProductCategory]()
    
    var titleButton = ""
    
    let productCategoryViewModel = ProductsCategoryViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showActivityIndicator(indicator: self.indicator, startIndicator: true)
        
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
        self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
        
    }
    
    @IBAction func shoesBtnAction(_ sender: UIButton) {
        
        let buttonShoesTitle = shoesBtnOutlet?.titleLabel?.text
        getSubCategory(arrayOfAllProducts: arrayOfAllProducts, productType: buttonShoesTitle)
        self.showActivityIndicator(indicator: self.indicator, startIndicator: true)
    }
    
    @IBAction func accessoriesBtnAction(_ sender: UIButton) {
        
        let buttonAccessoriesTitle = sender.titleLabel?.text
        getSubCategory(arrayOfAllProducts: arrayOfAllProducts, productType: buttonAccessoriesTitle)
        self.showActivityIndicator(indicator: self.indicator, startIndicator: true)
        
    }
    
    @IBAction func tshirtBtnAction(_ sender: UIButton) {
        let buttonTshirtTitle = sender.titleLabel?.text
        getSubCategory(arrayOfAllProducts: arrayOfAllProducts, productType: buttonTshirtTitle)
        self.showActivityIndicator(indicator: self.indicator, startIndicator: true)
        
    }
    
    
    @IBAction func allProductBtn(_ sender: UIButton) {
        
        if let passShoesCategoryDelegate = passShoesCategoryDelegate {
            passShoesCategoryDelegate.setSubCategory(subCategory: arrayOfAllProducts)
            self.showActivityIndicator(indicator: self.indicator, startIndicator: true)
        }
        
        dismissSubCategoryVc()
    }
    
    
    
    @IBAction func dismissBtn(_ sender: UIButton) {
        dismissSubCategoryVc()
        print("Pressed")
    }
    
    
    @IBAction func dismissBtnInView(_ sender: UIButton) {
        dismissSubCategoryVc()
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


