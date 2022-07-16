//
//  Address Screen.swift
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


class Address_Screen: UIViewController {
    @IBOutlet weak var adress: UILabel!
    let db = Firestore.firestore()
    let indicator = NVActivityIndicatorView(frame: .zero, type: .ballSpinFadeLoader, color: .systemRed, padding: 0)
    var userId : String?
    var TotalPrice : Double?
    @IBOutlet weak var country: UITextField!
    
    @IBAction func Confirm(_ sender: UIButton) {
        self.showActivityIndicator(indicator: self.indicator, startIndicator: true)
        if name.text == "" || city.text == "" || country.text == "" {
            showActivityIndicator(indicator: self.indicator, startIndicator: false)
            emptyData()
        }else {
            db.collection("Adress").document(userId!).setData(["streat":name.text!,"city":city.text!,"country":country.text!])
            let vc = UIStoryboard(name: "ConfirmOrder", bundle: nil).instantiateViewController(withIdentifier: "confirm") as? ConfirmOrder
            vc!.userId = userId
            vc?.TotalPrice = TotalPrice
            vc?.checkAddress = "Temp"
            vc?.temp = "\(country.text!),\(city.text!),\(name.text!)"
            
            self.navigationController!.pushViewController(vc!, animated: true)
            showActivityIndicator(indicator: self.indicator, startIndicator: false)
        }
        
        
        
    }
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var name: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
}
extension Address_Screen {
    func emptyData (){
        let alert = UIAlertController(title: "Sorry", message: "you must fill all data ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
}
}
