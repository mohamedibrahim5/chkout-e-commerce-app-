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
import NVActivityIndicatorView


class LoginScreenViewController: UIViewController {
    
    var btnSelected = true
    
    let indicator = NVActivityIndicatorView(frame: .zero, type: .ballSpinFadeLoader, color: .systemRed, padding: 0)

  
    static var idUser:String = ""
    let db = Firestore.firestore()
    static var name : String = ""
    static var checkname : String = ""
    var loginVariable : Login?
    @IBOutlet weak var password2: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBAction func login(_ sender: UIButton) {
        loginAccount(emailName: email.text!, password: password2.text!)
    }
//    @IBAction func LoginWithFscebook(_ sender: UIButton) {
//        loginByFacebook()
//    }

    @IBAction func google(_ sender: UIButton) {
        loginByGoogle()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginVariable = Login(name: LoginScreenViewController.name, checkName: LoginScreenViewController.checkname,idUser: LoginScreenViewController.idUser)
        password2.isSecureTextEntry = true
        if UserDefaults.standard.bool(forKey: "Login") {
            navigateTabBar(animted: false)
        }
    }

}
extension LoginScreenViewController {
    func autoLogin () {
        UserDefaults.standard.set(true, forKey: "Login")
        UserDefaults.standard.set(loginVariable?.idUser, forKey: "Login1")
    }
    func loginAccount (emailName:String,password:String) {
        indecator(indicator: indicator, check: true)
        Auth.auth().signIn(withEmail: emailName, password: password) {[self] authResult, error in
            if authResult != nil {
                loginVariable?.idUser = Auth.auth().currentUser!.uid
                email.text = ""
                password2.text = ""
                navigateTabBar(animted: true)
               
            }
            if error != nil {
                alert(title: Alert.sorry.rawValue, message: Alert.wrongLogin.rawValue)
                indecator(indicator: indicator, check: false)
            }
        }
        indecator(indicator: indicator, check: true)
    }
    func loginByFacebook () {
        indecator(indicator: indicator, check: true)
    
    
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
        loginManger.logIn(permissions: ["public_profile","email"], from: self,handler: { [self](result,error) in
            if result != nil {
                indecator(indicator: indicator, check: false)
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
            let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
            Auth.auth().signIn(with: credential) { [self] user, error in
                if user != nil {
                  
                    let ref = Database.database().reference()
                    let usersReference = ref.child("user_profiles").child((user?.user.uid)!)
                    let graphRequest : GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields": "id, name, email"])
                    graphRequest.start(completionHandler: { [self] connection, restult, error in
                        if error != nil {
                            indecator(indicator: indicator, check: false)
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
                            AddNameToFirebase(name: values["name"] as! String, uid: user!.user.uid)
                            usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                            if err != nil {
                            print(err ?? "Error saving user to database")
                                return
                                }
                            })
                        }
                    })
                    
                    loginVariable?.idUser = Auth.auth().currentUser!.uid
                    navigateTabBar(animted: true)
                }
                if error != nil {
                    print("login error")
                    return
                }
            }
        })
        
        indecator(indicator: indicator, check: true)
    }
    func loginByGoogle() {
        indecator(indicator: indicator, check: true)
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [self] user, error in

            if user != nil {
                indecator(indicator: indicator, check: false)
            }
            if let error = error {
                indecator(indicator: indicator, check: false)
          print(error)
          }
            guard let auth = user?.authentication else {
                indecator(indicator: indicator, check: false)
                return
            }
            let credintal = GoogleAuthProvider.credential(withIDToken: auth.idToken!, accessToken: auth.accessToken)
            Auth.auth().signIn(with: credintal) { [self] AuthResult, error in
                if let error = error {
                    indecator(indicator: indicator, check: false)
                    print(error)
                }
                if AuthResult != nil {
                     let name = Auth.auth().currentUser?.displayName
                    AddNameToFirebase(name: name!, uid: Auth.auth().currentUser!.uid)
                    loginVariable?.idUser = Auth.auth().currentUser!.uid
                    navigateTabBar(animted: true)
                }
            }
        }
        indecator(indicator: indicator, check: true)
    }
    func navigateTabBar (animted:Bool) {
        let vc = UIStoryboard(name: "HomePageScreen", bundle: nil).instantiateViewController(withIdentifier: "cell") as? HomePageScreanTabBarController
        if animted {
            autoLogin()
        }
        indecator(indicator: indicator, check: false)
        self.navigationController!.pushViewController(vc!, animated: animted)
    }
    func AddNameToFirebase (name:String,uid:String) {
        self.db.collection("customerinformation").document(Auth.auth().currentUser!.uid).setData(["name":name,"uid":uid])
        AddingEmailInApi(name:  name, email: (Auth.auth().currentUser?.email)!, password: "********", uidFirebase: Auth.auth().currentUser!.uid)
    }
     
    
}

