//
//  FavouriteScreenViewController.swift
//  Merita
//
//  Created by mohamed ibrahim on 10/07/2022.
//

import UIKit
import  NVActivityIndicatorView
class FavouriteScreenViewController: UIViewController {
    
    let indicator = NVActivityIndicatorView(frame: .zero, type: .ballSpinFadeLoader, color: .systemRed, padding: 0)
    var userId : String?
    var arrayOfProduct : [ProductCategory] = [ProductCategory]()
    let productCategoryViewModel = ProductsCategoryViewModel()
    var arrayOfData : [Favourite] = []
    var arrayTitle : [String] = []
    var numberOfIndexPath : Int?
    
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        productCategoryViewModel.fetchProductCategory()
        productCategoryViewModel.bindingProductCategory = { productsCategory, error in
            if let productsCategory = productsCategory {
                self.arrayOfProduct = productsCategory
                DispatchQueue.main.async {
                    self.arrayTitle.removeAll()
                    for index in 0..<self.arrayOfProduct.count{
                        self.arrayTitle.append(self.arrayOfProduct[index].title!)
                    }
                }
                if let error = error{
                    print("error\(error.localizedDescription)")
                }
            }
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        indecator(indicator: indicator, check: true)
        getDataFromFirebase(collection: "FAV", userId: self.userId!, arrayOfField: ["name","price","image"]) { [self]arrayOfData in
            self.arrayOfData = arrayOfData
            tableview.reloadData()
            indecator(indicator: indicator, check: false)
        }
       
}
    override func viewDidAppear(_ animated: Bool) {
        if arrayOfData.count == 0 {
            tableview.isHidden = true
        }
    }
}

