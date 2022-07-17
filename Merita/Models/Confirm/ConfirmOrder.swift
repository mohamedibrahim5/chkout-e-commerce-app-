//
//  ConfirmOrder.swift
//  Merita
//
//  Created by mohamed ibrahim on 16/07/2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase
import Firebase
class ConfirmOrder: UIViewController {
    let db = Firestore.firestore()
    var city2 : String = ""
    var country2 : String = ""
    var streat2 : String = ""
    var temp : String?
    var userId : String?
    var TotalPrice : Double?
    var arrOfProduct : [String] = []
    var checkAddress : String?
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    override func viewDidLoad() {
        totalPrice.text = "\(TotalPrice!)$"
        if checkAddress == "Temp" {
            address.text = temp
        }
        super.viewDidLoad()
    }
    func getCurrentData () -> String {
        let formater = DateFormatter()
        formater.dateStyle = .long
        formater.timeStyle = .medium
        let str = formater.string(from: Date())
        return str
    }
    override func viewWillAppear(_ animated: Bool) {
        if checkAddress == "main" {
            let docRef = db.collection("AdressMain").document(self.userId!)
            docRef.getDocument { [self] doc, error in
                if let doc = doc ,doc.exists {
                    self.city2 = doc["city"] as! String
                    self.country2 = doc["country"] as! String
                    self.streat2 = doc["streat"] as! String
                    address.text = "\(self.country2),\(self.city2),\(self.streat2)"
                }
            }
        }
       
        del()
    }

    @IBAction func checkOrder(_ sender: UIButton) {
        confirm()
       
    }
}


extension ConfirmOrder {

    func del (){
        let db = Firestore.firestore()
        db.collection("Cart").document(self.userId!).collection("all information").getDocuments {snapshot, error in
            if error == nil && snapshot != nil {
                for document in snapshot!.documents{
                    print("koko\(document.documentID)")
                    self.arrOfProduct.append(document.documentID)
                }
            }
        }

    }
    
    
    
    
    
    func confirm (){
        let alert = UIAlertController(title: "Done", message: "Are you want to Check This Order ", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { [self] (action) in
            let db = Firestore.firestore()
            for index in 0..<arrOfProduct.count {
                db.collection("Cart").document(self.userId!).collection("all information").document(arrOfProduct[index]).delete{ (error) in
                    if error == nil {
                        print("delete is done \(self.userId!)")
                        
                    } else {
                        print("delete is not done ")
                    }
                }

            }
            let vc = UIStoryboard(name: "HomePageScreen", bundle: nil).instantiateViewController(withIdentifier: "cell") as? HomePageScreanTabBarController
            db.collection("order").document(self.userId!).collection("all information").document(self.getCurrentData()).setData(["address":self.address.text!,"price":self.TotalPrice!,"time":self.getCurrentData()], merge: true)
            self.navigationController!.pushViewController(vc!, animated: true)
            self.scheduleNotifictionOrder()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in})
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
    func scheduleNotifictionOrder(){
        let content = UNMutableNotificationContent()
        content.title = "You Are Add It in Order"
        content.sound = .default
        content.badge = 0
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(2), repeats: false)
      let request = UNNotificationRequest(identifier: "OrderId", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
  
}


//self.showActivityIndicator(indicator: self.indicator, startIndicator: true)
//print(productId!)
//print(productIdString!)
//if userId == nil {
//    showAlertLogin()
//} else {
//    let db = Firestore.firestore()
//  let docRef = db.collection("Cart").document("\(userId!)").collection("all information").document("\(productIdString!)")
//  docRef.getDocument { (document, error) in
//      if let document = document, document.exists {
//          print("add to Cart")
//          let checkFovuritename = db.collection("Cart").document("\(self.userId!)").documentID
//          print(checkFovuritename)
//          if checkFovuritename == self.userId! {
//              self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
//              self.repetedCart()
//          }
//          else {
//              print("add to Cart")
//              db.collection("Cart").document("\(self.userId!)").collection("all information").document("\(self.productIdString!)").setData(["price":self.productprice!,"name":self.productName.text!,"image":self.productimage!,"DouplePrice":self.productPriceDouble!], merge: true)
//          }
//      }
//      else {
//              print("add to Cart")
//              print("Document does not exist")
//          self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
//          self.scheduleNotifictionCart()
//          db.collection("Cart").document("\(self.userId!)").collection("all information").document("\(self.productIdString!)").setData(["price":self.productprice!,"name":self.productName.text!,"image":self.productimage!,"productid":self.productId!,"DouplePrice":self.productPriceDouble!], merge: true)
//      }
//  }
//}
