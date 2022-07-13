//
//  TVCellForCategory.swift
//  Merita
//
//  Created by Abo Saleh on 05/07/2022.
//

import UIKit

class TVCellForCategory: UITableViewCell {
    
    @IBOutlet weak var categoryItemCV: UICollectionView!{
        didSet{
            categoryItemCV.delegate = self
            categoryItemCV.dataSource = self
        }
    }
    
     var delegateToPassProductsCategory : PassProductsCategory?

    
    var arrayOfCategory = [CustomCollection]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let homePageViewModel = HomePageViewModel()  // create view model object
        homePageViewModel.fetchCategories()         // call fetching function
          homePageViewModel.bindingCategory = { categories, error in
              if let categories = categories {
                  self.arrayOfCategory = categories
                  DispatchQueue.main.async {
                    //print(self.arrayOfCategory[0].title)
                      self.arrayOfCategory.remove(at: 0)
                      self.categoryItemCV.reloadData()
                  }
              }
              if let error = error {
                  print(error.localizedDescription)
              }
          }
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}



extension TVCellForCategory: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrayOfCategory.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellCategoryItems = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCellForCategoryItem", for: indexPath) as! CVCellForCategoryItem
        
        let categoryDetails = arrayOfCategory[indexPath.row]
        
        cellCategoryItems.configureCategoryItemCell(imageCategory: categoryDetails.image?.src ?? "", titleCategory: categoryDetails.title ?? "")
       
        return cellCategoryItems
        
    }
    
    
}

extension TVCellForCategory: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
//     func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        // "goToInsta"
//        
//        if segue.identifier == "goToProductsCategoryVC"{
//            if let indexPath = categoryItemCV.indexPathsForSelectedItems?.first {
//                
//                let destVC = segue.destination as! ProductsCategoryVC
//                
//                destVC.categoryTitle = arrayOfCategory[indexPath.row].title
//                
//                
//                //destVC.idUpcomingEventLeague =  idUpComming[indexPath.row]
//                
//                
//            }
//        }
//        
//        
//    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let delegateToPassProductsCategory = delegateToPassProductsCategory {
            
            delegateToPassProductsCategory.collectionView(collectionView, didSelectItemAt: indexPath, productsCategory: arrayOfCategory[indexPath.row].title ?? "")
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

          let padding: CGFloat =  10
          let collectionViewSize = collectionView.frame.size.height - padding

          return CGSize(width: 194, height: collectionViewSize/2)
      }

    
    
    
}
