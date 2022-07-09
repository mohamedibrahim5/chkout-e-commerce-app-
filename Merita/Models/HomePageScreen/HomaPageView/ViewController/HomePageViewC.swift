//
//  ViewControllerScreenOne.swift
//  Merita
//
//  Created by ahmed rabie on 01/07/2022.
//

import UIKit

class HomePageViewC: UIViewController {
    
    var name: String?
    
    @IBOutlet weak var brandsAndCategoryTV: UITableView!{
        didSet{
            brandsAndCategoryTV.dataSource = self
            brandsAndCategoryTV.delegate = self
            
        }
    }
    
    
    var arrayOfBrand = [SmartCollection]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let homePageViewModel = HomePageViewModel()  // create view model object
        homePageViewModel.fetchBrands()         // call fetching function
        homePageViewModel.bindingData = { brands, error in
            if let brands = brands {
                self.arrayOfBrand = brands
                DispatchQueue.main.async {
                    //    print(self.arrayOfBrand[0].title)
                    self.brandsAndCategoryTV.reloadData()
                }
            }
            if let error = error {
                print(error.localizedDescription)
            }
        }
        // Do any additional setup after loading the view.
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


extension HomePageViewC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellBrands = tableView.dequeueReusableCell(withIdentifier: "TVCellForBrands") as! TVCellForBrands
        
        let cellCategory = tableView.dequeueReusableCell(withIdentifier: "TVCellForCategory") as! TVCellForCategory
        
        
        
        switch indexPath.row {
        case 0:
            return cellBrands
        case 1:
            cellCategory.delegateToPassProductsCategory = self
            return cellCategory
        default:
            return UITableViewCell()
        }
    }
    
}

extension HomePageViewC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 285
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // "goToInsta"
        
        if segue.identifier == "goToProductsCategoryVC"{
            
            let destVC = segue.destination as! ProductsCategoryVC
            
            destVC.categoryTitle = name
            
            
        }
        
        
    }
    
    
    
    
    
    
    
}

extension HomePageViewC: PassProductsCategory {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, productsCategory: String) {
        
        //        if let indexPath = collectionView.indexPathsForSelectedItems?.first{
        //
        //
        //        }
        name = productsCategory
        print("TitleCategory \(name ?? "hhhh")")
        
        if let viewController = UIStoryboard(name: "ProductsCategoryScreen", bundle: nil).instantiateViewController(withIdentifier: "ProductsCategoryVC") as? ProductsCategoryVC {
            
            viewController.categoryTitle = name
            
            if let navigator = navigationController {
                
                navigator.pushViewController(viewController, animated: true)
                
            }
            
        }
        
        
    }
    
    
}
