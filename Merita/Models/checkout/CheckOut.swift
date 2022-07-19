//
//  CheckOut.swift
//  Merita
//
//  Created by mohamed ibrahim on 16/07/2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase
import Firebase
import  NVActivityIndicatorView
class CheckOut: UIViewController {
    @IBAction func ApplePayment(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "https://www.apple.com/apple-pay/")! as URL, options: [:], completionHandler: nil )
    }
    let indicator = NVActivityIndicatorView(frame: .zero, type: .ballSpinFadeLoader, color: .systemRed, padding: 0)
    @IBOutlet weak var valuecop: UILabel!
    let db = Firestore.firestore()
    var copon : Double = 0
    var totalPRice :Double?
     var x : Int = 0
    @IBAction func con(_ sender: UIButton) {
        print(totalPRice!)
        let vc = UIStoryboard(name: "OrderScreen", bundle: nil).instantiateViewController(withIdentifier: "order") as? OrderScreen
        vc?.TotalPrice = totalPRice
        vc!.userId = userId
        self.navigationController!.pushViewController(vc!, animated: true)
    }
    @IBAction func add(_ sender: UIButton) {
        self.showActivityIndicator(indicator: self.indicator, startIndicator: true)
        if x == 1 {
            Addit()
        }
        
        db.collection("cop").getDocuments { [self] snapshot, error in
            if error == nil && snapshot != nil {
                for document in snapshot!.documents{
                    if self.cop.text == document.documentID && x==0{
                        let textcop = document.data()["cop"] as! String
                        copon = Double(textcop) ?? 0
                        total.text = "\(totalPrice! + 11 - copon)"
                        totalPRice = totalPrice! + 11 - copon
                        cop.isSelected = false
                        valuecop.text = "copon is \(cop.text!),value of copon is \(copon)"
                        x = 1
                    }
                }
                if x == 0 {
                    self.emptyData()
                }
            }
        }
        self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
    }
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var cop: UITextField!
    @IBOutlet weak var price: UILabel!
    var userId : String?
    var totalPrice:Double?
    override func viewDidLoad() {
        super.viewDidLoad()
        price.text = "\(totalPrice!)"
        
        total.text = "\(totalPrice! + 11 - copon)"
        totalPRice = totalPrice! + 11 - copon
    }

}
extension CheckOut {
    func emptyData (){
        let alert = UIAlertController(title: "Sorry", message: "you copon is wrong ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
}
    func Addit (){
        let alert = UIAlertController(title: "Sorry", message: "you are add copoun before ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
}

}
