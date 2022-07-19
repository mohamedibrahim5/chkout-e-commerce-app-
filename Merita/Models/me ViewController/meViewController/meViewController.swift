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
import  NVActivityIndicatorView

class meViewController: UIViewController {
    let indicator = NVActivityIndicatorView(frame: .zero, type: .ballSpinFadeLoader, color: .systemRed, padding: 0)
    var arrayOfProduct = [ProductCategory]()
    let productCategoryViewModel = ProductsCategoryViewModel()
    var arrayTitle : [String] = []
    var numberOfIndexPath : Int?
    var arrayTotalPrice : [Double] = []
    var arrayTime : [String] = []
    var arrayAddress : [String] = []
    var arrayOfData : [Favourite] = []
    var arrayOfDataOrder:[Favourite] = []
    var checkFav : Double = 1
   
    @IBOutlet weak var wishListTableview: UITableView!{
        didSet{
            wishListTableview.dataSource = self
            wishListTableview.delegate = self
        }
    }
    
    @IBOutlet weak var orderTableView: UITableView!{
        didSet{
            orderTableView?.dataSource = self
            orderTableView?.delegate = self
        }
    }
    
    @IBAction func settings(_ sender: UIBarButtonItem) {
        if userId != nil {
            let vc = UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(withIdentifier: "setting") as? settings
            vc?.userId = userId
            
            self.navigationController!.pushViewController(vc!, animated: true)
        } else {
            loginAlert()
            
        }
       
    }
    
    @IBAction func cart(_ sender: UIBarButtonItem) {
        if userId != nil {
            print("ordersMore")
            let vc = UIStoryboard(name: "AddCartScreen", bundle: nil).instantiateViewController(withIdentifier: "cartcell") as? cartViewController
            vc!.userId = userId
            self.navigationController!.pushViewController(vc!, animated: true)
        } else {
            loginAlert()
        }
       
        
    }
    @IBAction func washListMore(_ sender: UIButton) {
        if userId != nil {
            print("washListMore")
            let vc = UIStoryboard(name: "Favourite Screen", bundle: nil).instantiateViewController(withIdentifier: "cell2") as? FavouriteScreenViewController
            vc!.userId = userId
            self.navigationController!.pushViewController(vc!, animated: true)
        } else {
            loginAlert()
        }
       
    }
   
    @IBAction func ordersMore(_ sender: UIButton) {
        if userId != nil {
            let vc = UIStoryboard(name: "MYOrderScreen", bundle: nil).instantiateViewController(withIdentifier: "MYOrderVC") as? MYOrderVC
            
            vc!.userId = userId
            self.navigationController!.pushViewController(vc!, animated: true)
        } else {
            loginAlert()
        }
        
        
    }
    @IBOutlet weak var welcome: UILabel!
    var userId : String?
    @IBOutlet weak var nameOfCustomer: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orderTableView.register(UINib(nibName: "OrderTVCell", bundle: nil), forCellReuseIdentifier: "OrderTVCell")
        
        
        productCategoryViewModel.fetchProductCategory()
        productCategoryViewModel.bindingProductCategory = { productsCategory, error in
            if let productsCategory = productsCategory {
                self.arrayOfProduct = productsCategory
                DispatchQueue.main.async {
                    self.arrayTitle.removeAll()
                    for index in 0..<self.arrayOfProduct.count{
                        self.arrayTitle.append(self.arrayOfProduct[index].title!)
                    }
                }
                if let error = error{
                    print("error\(error.localizedDescription)")
                }
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        if userId != nil {
                    self.showActivityIndicator(indicator: self.indicator, startIndicator: true)
                    let db = Firestore.firestore()
                    let docRef = db.collection("customerinformation").document(Auth.auth().currentUser!.uid)
                    docRef.getDocument { (document, error) in
                        if let document = document, document.exists {
                            self.welcome.text = "Welcome"
                            self.nameOfCustomer.text = document["name"] as? String
                            self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                        } else {
                            self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                            print("Document does not exist")
                        }
                    }
            
            
                    getDataFromFirebase(collection: "FAV", userId: self.userId!, arrayOfField: ["name","price","image"]) { [self]arrayOfData in
                        self.arrayOfData = arrayOfData
                       wishListTableview.reloadData()
                    }
            
                    db.collection("order").document("\(self.userId!)").collection("all information").getDocuments { (snapshot, error) in
            
                        if error == nil && snapshot != nil {
                            self.arrayTime.removeAll()
                            self.arrayAddress.removeAll()
                            self.arrayTotalPrice.removeAll()
                            for document in snapshot!.documents {
                            self.arrayTime.append(document.data()["time"] as! String)
                            self.arrayTotalPrice.append(document.data()["price"] as! Double)
                            self.arrayAddress.append(document.data()["address"] as! String)
                            self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
            
            
                    }
            
                            self.orderTableView?.reloadData()
            
                    }
                        print("address \(self.arrayAddress)")
            
                    }
        }
}
}

extension meViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        switch tableView {
        case orderTableView:
            print("address = TableViewTop")
            if arrayAddress.count > 2 {
                return 2
            }else{
                return arrayAddress.count
            }
        case wishListTableview:
            print("address = TableviewBotton")
            if arrayOfData.count  > 2 {
                return 2
            } else {
                return arrayOfData.count
            }
            
        default:
            print("Somthig wrong")
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellDame = UITableViewCell()
        switch tableView {
        case orderTableView:
            
            let orderCell = tableView.dequeueReusableCell(withIdentifier: "OrderTVCell", for: indexPath) as! OrderTVCell
            
            print("address \(arrayAddress)")
            print("address = TableViewTop")

            orderCell.address.text = arrayAddress[indexPath.row]
            orderCell.price.text = "\(arrayTotalPrice[indexPath.row])$"
            orderCell.date.text = arrayTime[indexPath.row]
            
        return orderCell
            
        case wishListTableview:
            let cell = tableView.dequeueReusableCell(withIdentifier: "washlistcell", for: indexPath) as! meWashListTableViewCell
            print("address = TableviewBotton")

            let index = indexPath.row
            cell.fetchSingleData(data: arrayOfData[index])
            return cell
        default:
            return cellDame
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == orderTableView{
            return 110
        }
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == wishListTableview{
            let vc = UIStoryboard(name: "ProductInfo", bundle: nil).instantiateViewController(withIdentifier: "cell") as? productInfoViewController
            getIndexPath(index: indexPath.row) { numberOfIndexPath in
                self.numberOfIndexPath = numberOfIndexPath
            }
            vc?.userId = userId
            vc?.arrayOfProducts = arrayOfProduct[numberOfIndexPath!]
            self.checkFav = Double(arrayOfData[indexPath.row].valueArrayPrice)!
            UserDefaults.standard.set(self.checkFav, forKey: "\(self.arrayOfProduct[numberOfIndexPath!].id!)")
            self.navigationController!.pushViewController(vc!, animated: true)
        }
        
        
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if tableView == wishListTableview{
            let deleteAtion = UIContextualAction(style: .destructive, title: "Delete") { [self] action, view, complationHandler in
                getIndexPath(index: indexPath.row) { numberOfIndexPath in
                    self.numberOfIndexPath = numberOfIndexPath
                }
                deleteFromFirebase(userId:self.userId!,productId:self.arrayOfProduct[self.numberOfIndexPath!].id!, collection: "FAV")
                UserDefaults.standard.set(0, forKey: "\(self.arrayOfProduct[self.numberOfIndexPath!].id!)")
                self.arrayOfData.remove(at: indexPath.row)
                self.wishListTableview.beginUpdates()
                self.wishListTableview.deleteRows(at: [indexPath], with: .automatic)
                self.wishListTableview.endUpdates()
                complationHandler(true)
            }

            return UISwipeActionsConfiguration(actions: [deleteAtion])
        }
        else {
            return nil
        }

    }
}
extension meViewController {
    func getIndexPath (index:Int,completion:@escaping(Int)->()) {
        let checkName = arrayOfData[index].valueArrayName
        for i in 0..<self.arrayOfProduct.count{
            if checkName == self.arrayOfProduct[i].title {
                self.numberOfIndexPath = i
                completion(numberOfIndexPath!)
            }
        }

    }
}
