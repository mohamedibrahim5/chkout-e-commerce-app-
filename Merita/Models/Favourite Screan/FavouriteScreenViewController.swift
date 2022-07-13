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

class FavouriteScreenViewController: UIViewController {
    
    var arrFav : Dictionary<String, Any>?
    var arrayPrice2 : [String] = []
    var arrayName : [String] = []
    var arrImage : [String] = []
    var userId : String?
    var valueArray: [String] = []
    var valueArrayprice: [String] = []
    var valueArrayimage: [String] = []
    var currencyArray: [String] = []
    
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
                        let db = Firestore.firestore()
                db.collection("FAV").document("\(self.userId!)").collection("all information").getDocuments { (snapshot, error) in
                    
                    if error == nil && snapshot != nil {
                        for document in snapshot!.documents {
                            print("roro\(document.documentID)")
                        self.valueArray.append(document.data()["name"] as! String)
                        self.valueArrayprice.append(document.data()["price"] as! String)
                        self.valueArrayimage.append(document.data()["image"] as! String)
                          
                }
                        self.tableview.reloadData()
            }
                    
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
       cell.imageview.sd_setImage(with: URL(string: valueArrayimage[indexPath.row]), placeholderImage: UIImage(named: "test.jpeg"))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        107
    }
}
