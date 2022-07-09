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
