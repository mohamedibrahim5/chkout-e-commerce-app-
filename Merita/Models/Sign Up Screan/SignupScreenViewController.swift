//
//  SignupScreenViewController.swift
//  Merita
//
//  Created by mohamed ibrahim on 04/07/2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase
import Firebase

class SignupScreenViewController: UIViewController {
    
    let db = Firestore.firestore()
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBAction func customerSignup(_ sender: UIButton) {
        if email.text == "" || password.text == "" || name.text == "" {
            emptyEmailOrPassword()
        }
        else if  password.text!.count < 6 {
            showFailedPasswordAlert()
        }
        else {
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) { [self] authResult, error in
                if authResult != nil {
                    AddingEmailInApi(name: name.text!, email: email.text!, password: password.text!, uidFirebase: Auth.auth().currentUser!.uid)

                    db.collection("customerinformation").document(Auth.auth().currentUser!.uid).setData(["name":name.text!,"uid":authResult!.user.uid])

                    if  isPasswordValid(self.password.text!) == false {
                        showPasswordWeakAlert()
                    }
                    print(Auth.auth().currentUser!.uid)
                    self.showSuccesfulRegisterAlert()
                   
                    name.text = ""
                    email.text = ""
                    password.text = ""
                    
                }
                if let error = error {
                    print(error.localizedDescription)
                    self.showFaileEmailAlert()
                }
        }
    }
        
}
    @IBOutlet weak var customerPassword: UITextField!
    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var customerEmail: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

}
extension SignupScreenViewController{
    func emptyEmailOrPassword (){
        let alert = UIAlertController(title: "Sorry", message: "you must fill all data ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
}
    
    func showSuccesfulRegisterAlert(){
        let alert = UIAlertController(title: "Done", message: "You are register now  ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
}
    
    func showFailedPasswordAlert(){
        let alert = UIAlertController(title: "Sorry", message: "The password must be 6 characters long or more.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
}
    
    func showFaileEmailAlert(){
        let alert = UIAlertController(title: "Sorry", message: "The email address is already in use by another account or The email address is badly formatted.l", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
}
    
    func showPasswordWeakAlert(){
        let alert = UIAlertController(title: "Done", message: " you are register now but be careful your password is very weak", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
}
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
}
    func isPasswordValidMoreComplites(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Z].*[A-Z])(?=.*[!@#$&*])(?=.*[0-9].*[0-9])(?=.*[a-z].*[a-z].*[a-z]).{8}$")
        return passwordTest.evaluate(with: password)
}
}
