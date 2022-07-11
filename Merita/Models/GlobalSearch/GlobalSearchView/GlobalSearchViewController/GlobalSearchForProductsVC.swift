//
//  GlobalSearchForProudctsVC.swift
//  Merita
//
//  Created by Abo Saleh on 09/07/2022.
//

import UIKit

class GlobalSearchForProductsVC: UIViewController {
    
    @IBOutlet weak var allProductsCView: UICollectionView!{
        didSet{
            allProductsCView.dataSource = self
            allProductsCView.delegate = self
            allProductsCView.backgroundView?.backgroundColor = UIColor.clear
            allProductsCView.backgroundColor = UIColor.clear
        }
    }
    
    var arrayOfAllProducts = [ProductCategory]()
    //var arrayOfShoesCategory = [ProductCategory]()
    var titleButton = ""
    let productCategoryViewModel = ProductsCategoryViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productCategoryViewModel.fetchProductCategory()
        productCategoryViewModel.bindingProductCategory = { allProducts, error in
            if let allProducts = allProducts {
                self.arrayOfAllProducts = allProducts
                DispatchQueue.main.async {
                    self.allProductsCView.reloadData()
                }
                if let error = error{
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func subCategoryBtn(_ sender: UIButton) {
        
        print("HI")
        
        if let viewController = UIStoryboard(name: "SearchAllProductsScreen", bundle: nil).instantiateViewController(withIdentifier: "SubCategoryVC") as? SubCategoryVC {
            
            viewController.passShoesCategoryDelegate = self
            
            viewController.providesPresentationContextTransitionStyle = true
            viewController.definesPresentationContext = true
            viewController.modalTransitionStyle = .crossDissolve
            viewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext;
            viewController.view.backgroundColor = UIColor.clear
            
            self.present(viewController, animated: true, completion: nil)
            
        }
        
    }
    
}

extension GlobalSearchForProductsVC: SubCategoryProductsProtocol {
    
    func setSubCategory(subCategory: [ProductCategory]) {
        arrayOfAllProducts.removeAll()
        arrayOfAllProducts = subCategory
        allProductsCView.reloadData()
    }
    
    
}

extension GlobalSearchForProductsVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfAllProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let ProductCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AllProductsCViewCell", for: indexPath) as! AllProductsCViewCell
        
        
        let productDetails = arrayOfAllProducts[indexPath.row]
        
        ProductCell.configureAllProductCell(imageProduct: productDetails.image?.src ?? "", titleProduct: productDetails.title ?? "", priceProduct: productDetails.variants?[0].price ?? "")
        
        return ProductCell
    }
    
    
}

extension GlobalSearchForProductsVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let leftAndRightPaddings: CGFloat = 10
        let numberOfItemsPerRow: CGFloat = 5.0
        
        let width = (collectionView.frame.width-leftAndRightPaddings)/numberOfItemsPerRow
        return CGSize(width: width, height: width) // You can change width and height here as pr your requirement
        
    }
    
}


