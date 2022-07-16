//
//  AdressMain.swift
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
class AdressMain: UIViewController {
    @IBOutlet weak var address: UILabel!
    let indicator = NVActivityIndicatorView(frame: .zero, type: .ballSpinFadeLoader, color: .systemRed, padding: 0)
    var userId : String?
    var city2 : String = ""
    var country2 : String = ""
    var streat2 : String = ""
    let db = Firestore.firestore()

    @IBAction func save(_ sender: UIButton) {
        self.showActivityIndicator(indicator: self.indicator, startIndicator: true)
        if street.text == "" || city.text == "" || country.text == "" {
            emptyData()
        }else {
            db.collection("AdressMain").document(userId!).setData(["streat":street.text!,"city":city.text!,"country":country.text!])
            address.text = "\(self.country.text!),\(self.city.text!),\(self.street.text!)"
            street.text = ""
            city.text = ""
            country.text = ""
            
        }
        self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
    }
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var street: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
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
}



extension AdressMain {
    func emptyData (){
        let alert = UIAlertController(title: "Sorry", message: "you must fill all data ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
}
}
