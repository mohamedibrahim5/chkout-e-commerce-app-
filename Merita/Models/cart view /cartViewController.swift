//
//  cartViewController.swift
//  Merita
//
//  Created by mohamed ibrahim on 12/07/2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase
import SDWebImage

class cartViewController: UIViewController {
    
    var userId : String?
    var valueArray: [String] = []
    var valueArrayprice: [String] = []
    var valueArrayimage: [String] = []
    var arrayOfProduct : [ProductCategory] = [ProductCategory]()
    let productCategoryViewModel = ProductsCategoryViewModel()
    var arrayTitle : [String] = []
    var numberOfIndexPath : Int?

    
    @IBOutlet weak var numberOfProduct: UILabel!
    @IBOutlet weak var shippingfee: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    var numItemInCell : Int = 1
   
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
                        print(self.arrayTitle[index])
                    }
                }
                if let error = error{
                    print(error.localizedDescription)
                }
            }
        }
       
    }
    override func viewWillAppear(_ animated: Bool) {
                        let db = Firestore.firestore()
                db.collection("Cart").document("\(self.userId!)").collection("all information").getDocuments { (snapshot, error) in
                    
                    if error == nil && snapshot != nil {
                        self.valueArrayimage.removeAll()
                        self.valueArray.removeAll()
                        self.valueArrayprice.removeAll()
                        for document in snapshot!.documents {
                        self.valueArray.append(document.data()["name"] as! String)
                        self.valueArrayprice.append(document.data()["price"] as! String)
                        self.valueArrayimage.append(document.data()["image"] as! String)
                          
                }
                        self.tableview.reloadData()
            }
                    
        }
}
}


extension cartViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return valueArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cartcell", for: indexPath) as! cartTableViewCell
        cell.imageProduct.sd_setImage(with: URL(string: valueArrayimage[indexPath.row]))
        cell.nameProduct.text = valueArray[indexPath.row]
        cell.priceProduct.text = valueArrayprice[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAtion = UIContextualAction(style: .destructive, title: "Delete") { action, view, complationHandler in
            print(indexPath.row)
            print(self.valueArray[indexPath.row])
            let checkName = self.valueArray[indexPath.row]
            for i in 0..<self.arrayOfProduct.count{
                if checkName == self.arrayOfProduct[i].title {
                    self.numberOfIndexPath = i
                }
            }
            let db = Firestore.firestore()
            db.collection("Cart").document("\(self.userId!)").collection("all information").document("\(self.arrayOfProduct[self.numberOfIndexPath!].id!)").delete{ (error) in
                if error == nil {
                    print("delete is done ")
                } else {
                    print("delete is not done ")
                }
            }
            self.valueArray.remove(at: indexPath.row)
            self.valueArrayprice.remove(at: indexPath.row)
            self.valueArrayimage.remove(at: indexPath.row)
            self.tableview.beginUpdates()
            self.tableview.deleteRows(at: [indexPath], with: .automatic)
            self.tableview.endUpdates()
            if self.valueArray.count == 0 {
                self.tableview.isHidden = true
                self.tableview.reloadData()
            }
            complationHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAtion])
    }
    
    
}
