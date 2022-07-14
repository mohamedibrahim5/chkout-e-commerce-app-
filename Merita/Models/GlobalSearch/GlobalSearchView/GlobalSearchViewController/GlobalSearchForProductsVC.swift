//
//  GlobalSearchForProudctsVC.swift
//  Merita
//
//  Created by Abo Saleh on 09/07/2022.
//

import UIKit

class GlobalSearchForProductsVC: UIViewController {
    @IBOutlet weak var imageview: UIImageView!
    var searchText2 : [String] = []
    var filterData : [String] = []
    @IBOutlet weak var searchBar: UISearchBar!
    var userId : String?
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
        imageview.flash()
         if !UserDefaults.standard.bool(forKey: "ExecuteOnce") {
             imageview.isHidden = false
        UserDefaults.standard.set(true, forKey: "ExecuteOnce")
        }
       
    
        
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
    override class func validateValue(_ ioValue: AutoreleasingUnsafeMutablePointer<AnyObject?>, forKey inKey: String) throws {
        
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
        imageview.isHidden = true
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
        searchText2.removeAll()
        for i in 0..<self.arrayOfAllProducts.count {
            self.searchText2.append(self.arrayOfAllProducts[i].title!)
        }
        self.filterData = self.searchText2
        print("number of product \(filterData.count)")
        self.searchBar.delegate = self
        allProductsCView.reloadData()
    }
    
    
}

extension GlobalSearchForProductsVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterData.count
      //  return arrayOfAllProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let ProductCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AllProductsCViewCell", for: indexPath) as! AllProductsCViewCell
        
        
        let productDetails = arrayOfAllProducts[indexPath.row]
        ProductCell.configureAllProductCell(imageProduct: productDetails.image?.src ?? "", titleProduct: filterData[indexPath.row], priceProduct: productDetails.variants?[0].price ?? "")
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "ProductInfo", bundle: nil).instantiateViewController(withIdentifier: "cell") as? productInfoViewController
        vc?.arrayOfProducts = arrayOfAllProducts[indexPath.row]
        vc?.userId = userId
        self.navigationController!.pushViewController(vc!, animated: true)
    }
    
}

extension GlobalSearchForProductsVC : UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterData = searchText.isEmpty ? searchText2 : searchText2.filter({(dataString: String) -> Bool in
            return dataString.range(of: searchText, options: .caseInsensitive) != nil
        })

        allProductsCView.reloadData()
    }
}
