//
//  ViewControllerScreenOne.swift
//  Merita
//
//  Created by ahmed rabie on 01/07/2022.
//

import UIKit

class HomePageViewC: UIViewController {
    
    @IBOutlet var collection: UICollectionView!{
        didSet{
            collection.delegate = self
            collection.dataSource = self
        }
    }
    var arrayOfImages = [ UIImage(named: "imgOne")!, UIImage(named: "imgTwo")!, UIImage(named: "imgThree")!, UIImage(named: "imgFour")! ]

    var timer: Timer?
    var currentCellIndex = 0

    
    var titleCategory: String?
    var titleBrand: String?
    var userId:String?
    
    @IBOutlet weak var brandsAndCategoryTV: UITableView!{
        didSet{
            brandsAndCategoryTV.dataSource = self
            brandsAndCategoryTV.delegate = self
            
        }
    }
    
    
    var arrayOfBrand = [SmartCollection]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
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
    
    func startTimer()
    {
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(moveToNextIndex) , userInfo: nil, repeats: true)
    }
    @objc func moveToNextIndex()
    {
        if currentCellIndex < arrayOfImages.count - 1{
            currentCellIndex += 1
        }else
        {
            currentCellIndex = 0
        }
        
        collection.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
       // pc.currentPage = currentCellIndex
    }
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
            cellBrands.delegateToPassProductsBrand = self
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
            destVC.userId = userId
            
            destVC.categoryTitle = titleCategory
            
            
        }
        
        
    }
    
}

extension HomePageViewC: PassProductsBrand{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, productsBrandTitle: String){
        
        titleBrand = productsBrandTitle
        print("titleBrand \(titleBrand ?? "hhhh")")
        
        if let viewController = UIStoryboard(name: "ProductsCategoryScreen", bundle: nil).instantiateViewController(withIdentifier: "ProductsCategoryVC") as? ProductsCategoryVC {
            
            viewController.brandTitle = titleBrand
            viewController.userId = userId
            if let navigator = navigationController {
                
                navigator.pushViewController(viewController, animated: true)
                
            }
            
        }
        
    }
    
}

extension HomePageViewC: PassProductsCategory {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, productsCategory: String) {
        
        titleCategory = productsCategory
        print("TitleCategory \(titleCategory ?? "hhhh")")
        
        if let viewController = UIStoryboard(name: "ProductsCategoryScreen", bundle: nil).instantiateViewController(withIdentifier: "ProductsCategoryVC") as? ProductsCategoryVC {
            
            viewController.categoryTitle = titleCategory
            viewController.userId = userId
            if let navigator = navigationController {
                
                navigator.pushViewController(viewController, animated: true)
                
            }
            
        }
        
        
    }
    
    
}

extension HomePageViewC:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "adsCell", for: indexPath) as! AdsCollectionViewCell
        cell.imageCell.image = arrayOfImages[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize (width: collection.frame.width, height: collection.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
