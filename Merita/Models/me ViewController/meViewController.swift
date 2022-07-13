//
//  meViewController.swift
//  Merita
//
//  Created by mohamed ibrahim on 06/07/2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase
import SDWebImage

class meViewController: UIViewController {
    var arrFav : Dictionary<String, Any>?
    var arrayPrice2 : [String] = []
    var arrayName : [String] = []
    var arrImage : [String] = []
    var valueArrayimage : [String] = []
    var valueArrayprice : [String] = []
    var valueArray : [String] = []
    var arrayOfProduct = [ProductCategory]()
    let productCategoryViewModel = ProductsCategoryViewModel()
    var arrayTitle : [String] = []
    var numberOfIndexPath : Int?
   
    @IBOutlet weak var tableview: UITableView!
    
    @IBAction func settings(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func cart(_ sender: UIBarButtonItem) {
        print("ordersMore")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "cartcell") as! cartViewController
        vc.userId = userId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func washListMore(_ sender: UIButton) {
        print("washListMore")
        let vc = UIStoryboard(name: "Favourite Screen", bundle: nil).instantiateViewController(withIdentifier: "cell2") as? FavouriteScreenViewController
        vc!.userId = userId
        self.navigationController!.pushViewController(vc!, animated: true)
    }
   
    @IBAction func ordersMore(_ sender: UIButton) {
       
    }
    @IBOutlet weak var welcome: UILabel!
    var userId : String?
    @IBOutlet weak var nameOfCustomer: UILabel!
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
        let docRef = db.collection("customerinformation").document(Auth.auth().currentUser!.uid)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                self.welcome.text = "Welcome"
                self.nameOfCustomer.text = document["name"] as? String
            } else {
                print("Document does not exist")
            }
        }

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
              
        }
            
        }
}
}

extension meViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if valueArray.count  > 2 {
            return 2
        } else {
            return valueArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "washlistcell", for: indexPath) as! meWashListTableViewCell
        let index = indexPath.row
        cell.nameOfProduct.text = "\(valueArrayprice[index])$"
        cell.imageview.sd_setImage(with: URL(string: valueArrayimage[index]))
        cell.name.text = valueArray[index]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "ProductInfo", bundle: nil).instantiateViewController(withIdentifier: "cell") as? productInfoViewController
        let checkName = valueArray[indexPath.row]
        for i in 0..<arrayOfProduct.count{
            if checkName == arrayOfProduct[i].title {
                numberOfIndexPath = i
            }
        }
        vc?.arrayOfProducts = arrayOfProduct[numberOfIndexPath!]
        self.navigationController!.pushViewController(vc!, animated: true)
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
            db.collection("FAV").document("\(self.userId!)").collection("all information").document("\(self.arrayOfProduct[self.numberOfIndexPath!].id!)").delete{ (error) in
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
            complationHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAtion])
    }
}
