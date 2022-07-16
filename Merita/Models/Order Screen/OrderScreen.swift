//
//  OrderScreen.swift
//  Merita
//
//  Created by mohamed ibrahim on 16/07/2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase
import Firebase

class OrderScreen: UIViewController {
    let db = Firestore.firestore()
    var check : String = ""

    @IBAction func location(_ sender: UIButton) {
    }
    @IBAction func ConfirmOrder(_ sender: UIButton) {
        db.collection("AdressMain").getDocuments { [self] snapshot, error in
            if error == nil && snapshot != nil {
                for document in snapshot!.documents{
                    print("koko\(document.documentID)")
                    if self.userId == document.documentID {
                        check = userId!
                        print("Done")
                      
                    } else {
                        print("error")
                    }
                }
                if check == "" {
                    print("must add address")
                    emptyData()
                } else if check != "" {
                    let vc = UIStoryboard(name: "ConfirmOrder", bundle: nil).instantiateViewController(withIdentifier: "confirm") as? ConfirmOrder
                    vc!.userId = userId
                    vc?.TotalPrice = TotalPrice
                    vc?.checkAddress = "main"
                    self.navigationController!.pushViewController(vc!, animated: true)
                }
            }
        }
    }
    @IBAction func AddAdress(_ sender: UIButton) {
        let vc = UIStoryboard(name: "AdressScreen", bundle: nil).instantiateViewController(withIdentifier: "address") as? Address_Screen
        vc!.userId = userId
        vc?.TotalPrice = TotalPrice
        self.navigationController!.pushViewController(vc!, animated: true)
    }
    var TotalPrice :Double?
    var userId : String?
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}


extension OrderScreen {
    func emptyData (){
        let alert = UIAlertController(title: "Sorry", message: "you must add Address on your profile ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
}
}
