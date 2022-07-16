//
//  ViewController.swift
//  Merita
//
//  Created by ahmed rabie on 01/07/2022.
//

import UIKit
import  NVActivityIndicatorView
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase
import Firebase
class ProductsCategoryVC: UIViewController {
    var userId :String?
    let indicator = NVActivityIndicatorView(frame: .zero, type: .ballSpinFadeLoader, color: .systemRed, padding: 0)
    
    @IBOutlet weak var productCategoryCView: UICollectionView!{
        didSet{
            productCategoryCView.dataSource = self
            productCategoryCView.delegate = self
            productCategoryCView.backgroundView?.backgroundColor = UIColor.clear
            productCategoryCView.backgroundColor = UIColor.clear
        }
    }
    
    var arrayOfProducts = [ProductCategory]()
    let productCategoryViewModel = ProductsCategoryViewModel()
    
    var categoryTitle: String?
    var brandTitle: String?
    var arrayOfProductsCategory = [ProductCategory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showActivityIndicator(indicator: self.indicator, startIndicator: true)
        productCategoryViewModel.fetchProductCategory()
        productCategoryViewModel.bindingProductCategory = { productsCategory, error in
            if let productsCategory = productsCategory {
                self.arrayOfProducts = productsCategory
                DispatchQueue.main.async {
                    self.productCategoryCView.reloadData()
                }
                if let error = error{
                    print(error.localizedDescription)
                }
            }
            self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
        }
    }
}


extension ProductsCategoryVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        for category in self.arrayOfProducts {
            if let tags = category.tags{
                let string = tags
                if let categoryTitle = self.categoryTitle {
                    if string.lowercased().contains(categoryTitle.lowercased()) {
                        print("TitleCategory in viewDidLoad found")
                        print("TitleCategory in view: \(category.title?.lowercased() ?? "hossam")")
                        arrayOfProductsCategory.append(category)
                        
                    }
                    
                }
                
            }
        }
        
        for category in self.arrayOfProducts {
            if let vendor = category.vendor{
                if let brandTitle = brandTitle{
                    if vendor == brandTitle {
                        print("\(vendor) == \(brandTitle)")
                        arrayOfProductsCategory.append(category)
                    }
                }
                
            }
        }
        
        print("TitleCategory count  \(arrayOfProductsCategory.count)")
        return arrayOfProductsCategory.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellProductsCategory = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCategoryCViewCell", for: indexPath) as! ProductCategoryCViewCell
        
        
        let productCategoryDetails = arrayOfProductsCategory[indexPath.row]
        
        //MARK: -  Return Products In Category
        if let tags = productCategoryDetails.tags{
            
            let string = tags
            if let cTitle = categoryTitle{
                if string.lowercased().contains(cTitle.lowercased()) {
                    print("TitleCategory found")
                    
                    cellProductsCategory.configureProductCategoryCell(imageProduct: productCategoryDetails.images?[0].src ?? "", titleProduct: productCategoryDetails.title ?? "", priceProduct: productCategoryDetails.variants?[0].price ?? "")
                    
                }
            }
        }
        //MARK: - Return Products in Brand
        if let vendor = productCategoryDetails.vendor{
            if let brandTitle = brandTitle{
                if vendor == brandTitle {
                    print("\(vendor) == \(brandTitle)")
                    
                    cellProductsCategory.configureProductCategoryCell(imageProduct: productCategoryDetails.images?[0].src ?? "", titleProduct: productCategoryDetails.title ?? "", priceProduct: productCategoryDetails.variants?[0].price ?? "")
                    
                }
            }
            
        }
        
        
        return cellProductsCategory
    }
    
    
}


//MARK: - Extension for UICollectionViewDelegate

extension ProductsCategoryVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let leftAndRightPaddings: CGFloat = 10
        let numberOfItemsPerRow: CGFloat = 5.0
        
        let width = (collectionView.frame.width-leftAndRightPaddings)/numberOfItemsPerRow
        return CGSize(width: width, height: width) // You can change width and height here as pr your requirement
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "ProductInfo", bundle: nil).instantiateViewController(withIdentifier: "cell") as? productInfoViewController
        vc?.arrayOfProducts = arrayOfProductsCategory[indexPath.row]
        vc?.userId = userId
        check(numberOfIndexPath: indexPath.row)
        self.navigationController!.pushViewController(vc!, animated: true)
    }
    
}

extension ProductsCategoryVC {
    func check (numberOfIndexPath:Int){
        let db = Firestore.firestore()
        db.collection("Fav").document(self.userId!).collection("all information").getDocuments { [self]snapshot, error in
            if error == nil && snapshot != nil {
                for document in snapshot!.documents{
                    if document.documentID == "\(arrayOfProductsCategory[numberOfIndexPath].id!) "{
                        UserDefaults.standard.set(self.arrayOfProductsCategory[numberOfIndexPath].id, forKey: "fill")
                    }
                }
            }
        }
    }
}
