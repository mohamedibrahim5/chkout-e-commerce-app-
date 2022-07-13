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
    var mapname : [String] = []
    var mapPrice : [String] = []
    var mapImage : [String] = []
    var arrayOfProduct = [ProductCategory]()
    let productCategoryViewModel = ProductsCategoryViewModel()
   
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
    var dataDescription : String?
    var name : [String]?
    @IBOutlet weak var nameOfCustomer: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        productCategoryViewModel.fetchProductCategory()
        productCategoryViewModel.bindingProductCategory = { allProducts, error in
            if let allProducts = allProducts {
                self.arrayOfProduct = allProducts
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
                if let error = error{
                    print(error.localizedDescription)
                }
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        let db = Firestore.firestore()
db.collection("FAV").document("\(self.userId!)").collection("all information").getDocuments { (snapshot, error) in
    
    if error == nil && snapshot != nil {
        for document in snapshot!.documents {
        self.valueArray.append(document.data()["name"] as! String)
        self.valueArrayprice.append(document.data()["price"] as! String)
        self.valueArrayimage.append(document.data()["image"] as! String)
            let arr = self.valueArray
            let rediciendArray = arr.reduce(into: [:], { $0[$1,default:0] += 1})
            let sorteandolos = rediciendArray.sorted(by: {$0.value > $1.value })
            let arr2 = self.valueArrayprice
            let rediciendArray2 = arr2.reduce(into: [:], { $0[$1,default:0] += 1})
            let sorteandolos2 = rediciendArray2.sorted(by: {$0.value > $1.value })
            let arr3 = self.valueArrayimage
            let rediciendArray3 = arr3.reduce(into: [:], { $0[$1,default:0] += 1})
            let sorteandolos3 = rediciendArray3.sorted(by: {$0.value > $1.value })
            self.mapname = sorteandolos.map({$0.key})
            self.mapPrice = sorteandolos2.map({$0.key})
            self.mapImage = sorteandolos3.map({$0.key})
            self.tableview.reloadData()
          
}
      
}
    
}
                let docRef = db.collection("customerinformation").document(Auth.auth().currentUser!.uid)
                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        self.welcome.text = "Welcome"
                        self.nameOfCustomer.text = document["name"] as? String
                    } else {
                        print("Document does not exist")
                    }
                }
}
}
extension meViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if mapname.count  > 2 {
            return 2
        } else {
            return mapname.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "washlistcell", for: indexPath) as! meWashListTableViewCell
        let index = indexPath.row
        cell.nameOfProduct.text = "\(mapPrice[index])$"
        cell.imageview.sd_setImage(with: URL(string: mapImage[index]))
        cell.name.text = mapname[index]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "ProductInfo", bundle: nil).instantiateViewController(withIdentifier: "cell") as? productInfoViewController
        vc?.arrayOfProducts = arrayOfProduct[indexPath.row]
        self.navigationController!.pushViewController(vc!, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
