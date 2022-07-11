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
   
    @IBOutlet weak var tableview: UITableView!
    
    @IBAction func settings(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func cart(_ sender: UIBarButtonItem) {
    }
    @IBAction func washListMore(_ sender: UIButton) {
        print("washListMore")
     //   print(userId!)
        let vc = UIStoryboard(name: "Favourite Screen", bundle: nil).instantiateViewController(withIdentifier: "cell2") as? FavouriteScreenViewController
       // vc!.userId = userId
        self.navigationController!.pushViewController(vc!, animated: true)
    }
   
    @IBAction func ordersMore(_ sender: UIButton) {
        print("ordersMore")
    }
    @IBOutlet weak var welcome: UILabel!
    var userId : String = "P1vuOQ1tQZdIobdZKkCX7FvmcfA3"
    var dataDescription : String?
    var name : [String]?
    @IBOutlet weak var nameOfCustomer: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .fastForward, target: self, action: #selector(onShopping(_:))
//        )
       
    }
    override func viewWillAppear(_ animated: Bool) {
        
                        let db = Firestore.firestore()
                db.collection("FAV").document("\(self.userId)").collection("all information").getDocuments { (snapshot, error) in
                    
                    if error == nil && snapshot != nil {
                        for document in snapshot!.documents {
                        self.arrFav = document.data()
                        print(self.arrFav!["price"]!)
                        self.arrayPrice2.append(self.arrFav!["price"]! as! String)
                        self.arrayName.append(self.arrFav!["name"] as! String)
                        self.arrImage.append(self.arrFav!["image"] as! String)
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
        if arrayPrice2.count > 2 {
            return 2
        } else {
            return arrayPrice2.count
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "washlistcell", for: indexPath) as! meWashListTableViewCell
        let index = indexPath.row
        cell.nameOfProduct.text = arrayPrice2[index]
        cell.imageview.sd_setImage(with: URL(string: arrImage[index]), placeholderImage: UIImage(named: "test.jpeg"))
        cell.name.text = arrayName[index]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "ProductInfo", bundle: nil).instantiateViewController(withIdentifier: "cell") as? productInfoViewController
        self.navigationController!.pushViewController(vc!, animated: true)
    }
}
