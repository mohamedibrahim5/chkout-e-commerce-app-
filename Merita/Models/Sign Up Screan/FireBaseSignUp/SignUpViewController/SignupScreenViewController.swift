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
import NVActivityIndicatorView

class SignupScreenViewController: UIViewController {

    var btnSelected = true
    
    //let db = Firestore.firestore()
    let indicator = NVActivityIndicatorView(frame: .zero, type: .ballSpinFadeLoader, color: .systemRed, padding: 0)
    let db = Firestore.firestore()
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBAction func customerSignup(_ sender: UIButton) {
       if checkEmpty() {
           alert(title: Alert.sorry.rawValue, message: Alert.emptyFillData.rawValue)
        }
        else if  weakPassword() {
            alert(title: Alert.sorry.rawValue, message: Alert.weakPassword.rawValue)
        }
        else {
            signUp(name: name.text!, email: email.text!, password: password.text!, baseCollection: "customerinformation")
        }
        
}
    override func viewDidLoad() {
        super.viewDidLoad()
        password.isSecureTextEntry = true
    }
    
    @IBAction func showPassword(_ sender: UIButton) {
        
        btnSelected = !btnSelected
                if btnSelected == true {
                   sender.setImage(UIImage(named: "hidden.png"), for: .normal)
                    password.isSecureTextEntry = true
            } else {
                  sender.setImage(UIImage(named: "viewer.png"), for: .normal)
                password.isSecureTextEntry = false
                
            }
        
    }

}
extension SignupScreenViewController{
    func signUp (name:String,email:String,password:String,baseCollection:String) {
        indecator(indicator: indicator, check: true)
        Auth.auth().createUser(withEmail: email, password: password) { [self] authResult, error in
            if authResult != nil {
                AddingEmailInApi(name: name, email: email, password: password, uidFirebase: Auth.auth().currentUser!.uid)

                db.collection(baseCollection).document(Auth.auth().currentUser!.uid).setData(["name":name,"uid":authResult!.user.uid])

                if  isPasswordValid(password) == false {
                    alert(title: Alert.Done.rawValue, message: Alert.registerPasswordWeak.rawValue)
                    
                }
                alert(title: Alert.Done.rawValue, message: Alert.suucefulRegister.rawValue)
                emptyData()
                indecator(indicator: indicator, check: false)

                
            }
            if error != nil {
                alert(title: Alert.sorry.rawValue, message: Alert.failEmail.rawValue)
                indecator(indicator: indicator, check: false)
            }
    }
 }
    func checkEmpty () -> Bool {
        if email.text == "" || password.text == "" || name.text == "" {
         return true
        }else {
         return false
        }
    }
    func weakPassword () -> Bool {
      if  password.text!.count < 6 {
            return true
        }else {
            return false
        }
    }
    func emptyData () {
        name.text = ""
        email.text = ""
        password.text = ""
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
