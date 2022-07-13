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

class LoginScreenViewController: UIViewController {

    static var idUser:String = ""
    @IBOutlet weak var password2: UITextField!
    let db = Firestore.firestore()
    static var name : String = ""
    static var checkname : String = ""
    @IBOutlet weak var password: UIView!
    @IBOutlet weak var email: UITextField!
    @IBAction func login(_ sender: UIButton) {
        let vc = UIStoryboard(name: "HomePageScreen", bundle: nil).instantiateViewController(withIdentifier: "cell") as? HomePageScreanTabBarController
        Auth.auth().signIn(withEmail: email.text!, password: password2.text!) {[self] authResult, error in
            if authResult != nil {
                LoginScreenViewController.idUser = Auth.auth().currentUser!.uid
                print(LoginScreenViewController.idUser)
                vc?.id = LoginScreenViewController.idUser
                email.text = ""
                password2.text = ""
                self.navigationController!.pushViewController(vc!, animated: true)
               
            }
            if error != nil {
                    self.showReaptedEmailAlert()
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func LoginWithFscebook(_ sender: UIButton) {
        let vc = UIStoryboard(name: "HomePageScreen", bundle: nil).instantiateViewController(withIdentifier: "cell") as? HomePageScreanTabBarController
        let loginManger = LoginManager()
        loginManger.logIn(permissions: ["public_profile","email"], from: self,handler: {(result,error) in
            if result != nil {
            }
            if let error = error {
                print("failed to login")
                print(error.localizedDescription)
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
                            print("error")
                        }else {
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
                    vc?.id = LoginScreenViewController.idUser
                    self.navigationController!.pushViewController(vc!, animated: true)
                }
                if error != nil {
                    print("login error")
                    return
                }
            }
        })
        
       
    }
    
    
    
    
    
    
    @IBAction func google(_ sender: UIButton) {
        print(LoginScreenViewController.idUser)
        print(LoginScreenViewController.checkname)
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        password2.isSecureTextEntry = true
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
