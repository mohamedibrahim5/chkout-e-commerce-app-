//
//  LoginScreenViewController.swift
//  Merita
//
//  Created by mohamed ibrahim on 05/07/2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase
import FacebookCore
import FacebookLogin
import FBSDKLoginKit
import FBSDKCoreKit
import GoogleSignIn
import Firebase
import  NVActivityIndicatorView

class LoginScreenViewController: UIViewController {

    
    var btnSelected = true
    
    let indicator = NVActivityIndicatorView(frame: .zero, type: .ballSpinFadeLoader, color: .systemRed, padding: 0)
    static var idUser:String = ""
    @IBOutlet weak var password2: UITextField!
    let db = Firestore.firestore()
    static var name : String = ""
    static var checkname : String = ""
    @IBOutlet weak var password: UIView!
    @IBOutlet weak var email: UITextField!
    @IBAction func login(_ sender: UIButton) {
        self.showActivityIndicator(indicator: self.indicator, startIndicator: true)
       
        Auth.auth().signIn(withEmail: email.text!, password: password2.text!) {[self] authResult, error in
            if authResult != nil {
                LoginScreenViewController.idUser = Auth.auth().currentUser!.uid
                print(LoginScreenViewController.idUser)
                email.text = ""
                password2.text = ""
                UserDefaults.standard.set(true, forKey: "Login")
                let vc = UIStoryboard(name: "HomePageScreen", bundle: nil).instantiateViewController(withIdentifier: "cell") as? HomePageScreanTabBarController
            //   vc?.id = LoginScreenViewController.idUser
                self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { grented, error in
                    if grented  {
                        print("success")
                    }
                    else {
                        print("error")
                    }
                }
                UserDefaults.standard.set(LoginScreenViewController.idUser, forKey: "Login1")
                self.navigationController!.pushViewController(vc!, animated: true)
               
            }
            if error != nil {
                    self.showReaptedEmailAlert()
                self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
            }
        }
    }
    
    
    
    
    @IBAction func ShowPassword(_ sender: UIButton) {
        btnSelected = !btnSelected
                if btnSelected == true {
                   sender.setImage(UIImage(named: "hidden.png"), for: .normal)
                    password2.isSecureTextEntry = true
            } else {
                  sender.setImage(UIImage(named: "viewer.png"), for: .normal)
                password2.isSecureTextEntry = false
                
            }
    }
    
    
    
    
    
    
    
    @IBAction func LoginWithFscebook(_ sender: UIButton) {
        self.showActivityIndicator(indicator: self.indicator, startIndicator: true)
        let loginManger = LoginManager()
        loginManger.logIn(permissions: ["public_profile","email"], from: self,handler: {(result,error) in
            if result != nil {
                self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
            }
            if let error = error {
                print("failed to login")
                print(error.localizedDescription)
                self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                return
            }
            guard AccessToken.current != nil else {
                print("failed to get access token")
                return
            }
            let credential = FacebookAuthProvider
              .credential(withAccessToken: AccessToken.current!.tokenString)
            Auth.auth().signIn(with: credential) { user, error in
                if user != nil {
                  
                    let ref = Database.database().reference()
                    let usersReference = ref.child("user_profiles").child((user?.user.uid)!)
                    let graphRequest : GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields": "id, name, email"])
                    graphRequest.start(completionHandler: { connection, restult, error in
                        if error != nil {
                            self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                            print("error")
                        }else {
                            self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                            guard let data : [String:AnyObject] = restult as? [String:AnyObject] else {
                                print("Can't pull data from JSON")
                            return
                        }
                            guard let userName: String = data["name"] as? String else {
                            print("Can't pull username from JSON")
                                        return
                        }
                            let values = ["name": userName] as [String : Any]
                            self.db.collection("customerinformation").document(Auth.auth().currentUser!.uid).setData(["name":values["name"]!,"uid":user!.user.uid])
                            LoginScreenViewController.checkname = values ["name"] as! String
                            AddingEmailInApi(name:  LoginScreenViewController.checkname, email: (Auth.auth().currentUser?.email)!, password: "********", uidFirebase: Auth.auth().currentUser!.uid)
                            usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                                    // error in database save
                            if err != nil {
                            print(err ?? "Error saving user to database")
                                return
                                }
                            })
                        }
                    })
                    
                    LoginScreenViewController.idUser = Auth.auth().currentUser!.uid
                    print(LoginScreenViewController.idUser)
                    UserDefaults.standard.set(true, forKey: "Login")
                    let vc = UIStoryboard(name: "HomePageScreen", bundle: nil).instantiateViewController(withIdentifier: "cell") as? HomePageScreanTabBarController
                    self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { grented, error in
                        if grented  {
                            print("success")
                        }
                        else {
                            print("error")
                        }
                    }
                    UserDefaults.standard.set(LoginScreenViewController.idUser, forKey: "Login1")
                //    vc?.id = LoginScreenViewController.idUser
                    self.navigationController!.pushViewController(vc!, animated: true)
                }
                if error != nil {
                    self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                    print("login error")
                    return
                }
            }
        })
        
       
    }
    
    
    
    
    
    
    @IBAction func google(_ sender: UIButton) {
        self.showActivityIndicator(indicator: self.indicator, startIndicator: true)
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { user, error in

            if let error = error {
                self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
          print(error)
          }
            guard let auth = user?.authentication else { return }
            let credintal = GoogleAuthProvider.credential(withIDToken: auth.idToken!, accessToken: auth.accessToken)
            Auth.auth().signIn(with: credintal) { AuthResult, error in
                if let error = error {
                    self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                    print(error)
                }
                if AuthResult != nil {
                     let name = Auth.auth().currentUser?.displayName
                    self.db.collection("customerinformation").document(Auth.auth().currentUser!.uid).setData(["name":name!,"uid":Auth.auth().currentUser?.uid as Any])
                    AddingEmailInApi(name: name!, email: (Auth.auth().currentUser?.email)!, password: "********", uidFirebase: Auth.auth().currentUser!.uid)
                    LoginScreenViewController.idUser = Auth.auth().currentUser!.uid
                    UserDefaults.standard.set(true, forKey: "Login")
                    let vc = UIStoryboard(name: "HomePageScreen", bundle: nil).instantiateViewController(withIdentifier: "cell") as? HomePageScreanTabBarController
                    self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { grented, error in
                        if grented  {
                            print("success")
                        }
                        else {
                            print("error")
                        }
                    }
                    UserDefaults.standard.set(LoginScreenViewController.idUser, forKey: "Login1")
                       //         vc?.id = Auth.auth().currentUser?.uid
                                self.navigationController!.pushViewController(vc!, animated: true)
                }
            }
        }
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        password2.isSecureTextEntry = true
        if UserDefaults.standard.bool(forKey: "Login") {
            let vc = UIStoryboard(name: "HomePageScreen", bundle: nil).instantiateViewController(withIdentifier: "cell") as? HomePageScreanTabBarController
       //     vc?.id = LoginScreenViewController.idUser
            self.navigationController!.pushViewController(vc!, animated: false)
        }
    }

}
extension LoginScreenViewController {
    func showReaptedEmailAlert(){
        let alert = UIAlertController(title: "Sorry", message: "This Email or pass is wrongs ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    func showSuccesfulLoginAlert(){
        let alert = UIAlertController(title: "Done", message: "You are now able to buy anything easy \(LoginScreenViewController.name) ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
}
