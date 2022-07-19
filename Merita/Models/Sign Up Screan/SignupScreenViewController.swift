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
import  NVActivityIndicatorView

class SignupScreenViewController: UIViewController {
    
    var btnSelected = true
    
    let db = Firestore.firestore()
    let indicator = NVActivityIndicatorView(frame: .zero, type: .ballSpinFadeLoader, color: .systemRed, padding: 0)
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
  //  let varSignUp = SignUp(name: name.text, password: password.text, email: email.text)
    @IBAction func customerSignup(_ sender: UIButton) {
        self.showActivityIndicator(indicator: self.indicator, startIndicator: true)
       if checkEmpty() {
            self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
           alert(title: Alert.sorry.rawValue, message: Alert.emptyFillData.rawValue)
        }
        else if  weakPassword() {
            self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
            alert(title: Alert.sorry.rawValue, message: Alert.weakPassword.rawValue)
        }
        else {
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) { [self] authResult, error in
                if authResult != nil {
                    AddingEmailInApi(name: name.text!, email: email.text!, password: password.text!, uidFirebase: Auth.auth().currentUser!.uid)

                    db.collection("customerinformation").document(Auth.auth().currentUser!.uid).setData(["name":name.text!,"uid":authResult!.user.uid])

                    if  isPasswordValid(password.text!) == false {
                        showActivityIndicator(indicator: indicator, startIndicator: false)
                        alert(title: Alert.Done.rawValue, message: Alert.registerPasswordWeak.rawValue)
                        
                    }
                    showActivityIndicator(indicator: indicator, startIndicator: false)
                    alert(title: Alert.Done.rawValue, message: Alert.suucefulRegister.rawValue)
                    emptyData()

                    
                }
                if error != nil {
                    showActivityIndicator(indicator: indicator, startIndicator: false)
                    alert(title: Alert.sorry.rawValue, message: Alert.failEmail.rawValue)
                }
        }
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
    func signUp () {
        
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
    func alert (title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
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
