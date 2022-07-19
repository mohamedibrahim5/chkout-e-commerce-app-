//
//  MYOrderVC.swift
//  Merita
//
//  Created by Abo Saleh on 18/07/2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase
import SDWebImage
import  NVActivityIndicatorView


class MYOrderVC: UIViewController {
    
    var userId : String?
    
    @IBOutlet weak var myOrderTableView: UITableView!{
        didSet{
            myOrderTableView.delegate = self
            myOrderTableView.dataSource = self
        }
    }
    
    var arrayTotalPrice : [Double] = []
    var arrayTime : [String] = []
    var arrayAddress : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myOrderTableView.register(UINib(nibName: "OrderTVCell", bundle: nil), forCellReuseIdentifier: "OrderTVCell")
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        let db = Firestore.firestore()
        
        db.collection("order").document("\(self.userId!)").collection("all information").getDocuments { (snapshot, error) in
            
            if error == nil && snapshot != nil {
                self.arrayTime.removeAll()
                self.arrayAddress.removeAll()
                self.arrayTotalPrice.removeAll()
                for document in snapshot!.documents {
                self.arrayTime.append(document.data()["time"] as! String)
                self.arrayTotalPrice.append(document.data()["price"] as! Double)
                self.arrayAddress.append(document.data()["address"] as! String)
               
                  
        }
                
                self.myOrderTableView.reloadData()
              
        }
            print("address \(self.arrayAddress)")

        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MYOrderVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayAddress.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTVCell", for: indexPath) as! OrderTVCell
        
        cell.address.text = arrayAddress[indexPath.row]
        cell.price.text = "\(arrayTotalPrice[indexPath.row])$"
        cell.date.text = arrayTime[indexPath.row]
        return cell
    }
    
    
}

extension MYOrderVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}
