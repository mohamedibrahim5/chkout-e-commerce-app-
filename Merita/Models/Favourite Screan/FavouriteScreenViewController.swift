//
//  FavouriteScreenViewController.swift
//  Merita
//
//  Created by mohamed ibrahim on 10/07/2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase
import SDWebImage
import  NVActivityIndicatorView
class FavouriteScreenViewController: UIViewController {
    
    let indicator = NVActivityIndicatorView(frame: .zero, type: .ballSpinFadeLoader, color: .systemRed, padding: 0)
    var userId : String?
    var valueArray: [String] = []
    var valueArrayprice: [String] = []
    var valueArrayimage: [String] = []
    var arrayOfProduct : [ProductCategory] = [ProductCategory]()
    let productCategoryViewModel = ProductsCategoryViewModel()
    var arrayTitle : [String] = []
    var numberOfIndexPath : Int?
    
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
        self.showActivityIndicator(indicator: self.indicator, startIndicator: true)
                        let db = Firestore.firestore()
                db.collection("FAV").document("\(self.userId!)").collection("all information").getDocuments { (snapshot, error) in
                    
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
                        self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
            }
                    
        }
}
    override func viewDidAppear(_ animated: Bool) {
        if valueArray.count == 0 {
            tableview.isHidden = true
        }
    }
}
extension FavouriteScreenViewController :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return valueArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavouriteTableViewCell
        cell.name.text = valueArray[indexPath.row]
        cell.price.text = "\(valueArrayprice[indexPath.row])$"
       cell.imageview.sd_setImage(with: URL(string: valueArrayimage[indexPath.row]))
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "ProductInfo", bundle: nil).instantiateViewController(withIdentifier: "cell") as? productInfoViewController
        let checkName = valueArray[indexPath.row]
        for i in 0..<arrayOfProduct.count{
            if checkName == arrayOfProduct[i].title {
                numberOfIndexPath = i
                print("\(numberOfIndexPath!)")
                print("\(arrayOfProduct[numberOfIndexPath!].id!)")
                
            }
        }
        vc?.userId = userId
        vc?.arrayOfProducts = arrayOfProduct[numberOfIndexPath!]
        UserDefaults.standard.set(self.arrayOfProduct[numberOfIndexPath!].id, forKey: "fill")
        self.navigationController!.pushViewController(vc!, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAtion = UIContextualAction(style: .destructive, title: "Delete") { action, view, complationHandler in
            self.showActivityIndicator(indicator: self.indicator, startIndicator: true)
            print(indexPath.row)
            print(self.valueArray[indexPath.row])
            let checkName = self.valueArray[indexPath.row]
            for i in 0..<self.arrayOfProduct.count{
                if checkName == self.arrayOfProduct[i].title {
                    self.numberOfIndexPath = i
                }
            }
            let db = Firestore.firestore()
            db.collection("FAV").document("\(self.userId!)").collection("all information").document("\(self.arrayOfProduct[self.numberOfIndexPath!].id!)").delete{ (error) in
                if error == nil {
                    UserDefaults.standard.set(0, forKey: "fill")
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
            self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
        }
       
        return UISwipeActionsConfiguration(actions: [deleteAtion])
    }
}
