//
//  productInfoViewController.swift
//  Merita
//
//  Created by mohamed ibrahim on 03/07/2022.
//

import UIKit

class productInfoViewController: UIViewController {
    
    // coming from before screan
    var endpointid : String?
    var productInfoArray =  Product()

    @IBAction func favourite(_ sender: UIButton) {
        print("add to favourite")
    }
    @IBAction func addToCart(_ sender: UIButton) {
        print("add to cart")
    }
    @IBAction func more(_ sender: UIButton) {
        print("more")
    }
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        endpointid = "7730623709398"
        let productInfo = ProductInfoViewModel()
        productInfo.fetchData(endPoint: EndPoint.productInfo.rawValue, endPointId: endpointid!)
        productInfo.bindingData = { productInfo,error in
            if let productInfo = productInfo {
                self.productInfoArray = productInfo
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.collectionView.reloadData()
                }
            }
            if let error = error {
                print(error.localizedDescription)
            }
            
        }
        productName.text = productInfoArray.title
        print(productInfoArray)
        

    }

}



extension productInfoViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "productinfocell", for: indexPath) as! productInfoCollectionViewCell
        return cell
    }
}



extension productInfoViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celltable", for: indexPath) as! productInfoTableViewCell
        return cell
    }
    
    
}
