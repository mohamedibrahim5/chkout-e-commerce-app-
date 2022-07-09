//
//  TVCellForBrands.swift
//  Merita
//
//  Created by Abo Saleh on 05/07/2022.
//

import UIKit

class TVCellForBrands: UITableViewCell {

    @IBOutlet weak var brandsItemCV: UICollectionView!{
        didSet{
            brandsItemCV.delegate = self
            brandsItemCV.dataSource = self
        }
    }
    
    var arrayOfBrand = [SmartCollection]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let homePageViewModel = HomePageViewModel()  // create view model object
        homePageViewModel.fetchBrands()         // call fetching function
          homePageViewModel.bindingData = { brands, error in
              if let brands = brands {
                  self.arrayOfBrand = brands
                  DispatchQueue.main.async {
                  //    print(self.arrayOfBrand[0].title)
                      self.brandsItemCV.reloadData()
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


extension TVCellForBrands: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrayOfBrand.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellBrandItems = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCellForBrandsItem", for: indexPath) as! CVCellForBrandsItem
        
        let brandDetails = arrayOfBrand[indexPath.row]
        
        print("Brand Name: \(brandDetails.title ?? "") ")
        cellBrandItems.configureBrandItemCell(imageBrand: brandDetails.image?.src ?? "" , nameBrand: /*brandDetails.title ??*/ "")
        
        
        return cellBrandItems
        
    }
    
    
}

extension TVCellForBrands: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
 
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

           let padding: CGFloat =  10
           let collectionViewSize = collectionView.frame.size.height - padding

           return CGSize(width: 128, height: collectionViewSize/2)
       }

    
}
