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
    var userId : String = "P1vuOQ1tQZdIobdZKkCX7FvmcfA3"
    
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
                        let db = Firestore.firestore()
                db.collection("FAV").document("\(self.userId)").collection("all information").getDocuments { (snapshot, error) in
                    
                    if error == nil && snapshot != nil {
                        for document in snapshot!.documents {
                        self.arrFav = document.data()
                        self.arrayPrice2.append(self.arrFav!["price"]! as! String)
                        self.arrayName.append(self.arrFav!["name"] as! String)
                        self.arrImage.append(self.arrFav!["image"] as! String)
                        self.tableview.reloadData()
                }
            }
        }
}
}
extension FavouriteScreenViewController :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayPrice2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavouriteTableViewCell
        cell.name.text = arrayName[indexPath.row]
        cell.price.text = arrayPrice2[indexPath.row]
        cell.imageview.sd_setImage(with: URL(string: arrImage[indexPath.row]), placeholderImage: UIImage(named: "test.jpeg"))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        107
    }
    
    
}
