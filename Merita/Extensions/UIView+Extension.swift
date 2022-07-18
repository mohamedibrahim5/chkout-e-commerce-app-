//
//  UIView+Extension.swift
//  Merita
//
//  Created by Abo Saleh on 03/07/2022.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase
import SDWebImage
import  NVActivityIndicatorView

 extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var LeftRadius: CGFloat {
        get { return self.LeftRadius }
        set {
            self.layer.cornerRadius = newValue
            self.layer.maskedCorners = .layerMinXMaxYCorner
        }
    }
     
     @IBInspectable var BottonLAndRRadius: CGFloat {
          get { return self.BottonLAndRRadius }
          set {
              self.layer.cornerRadius = newValue
              self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
          }
         
      }
      
      
      @IBInspectable var TopLAndRRadius: CGFloat {
           get { return self.TopLAndRRadius }
           set {
               self.layer.cornerRadius = newValue
               self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
           }
      }
    /*
    
    /* The color of the shadow. Defaults to opaque black. Colors created
    * from patterns are currently NOT supported. Animatable. */
    @IBInspectable var shadowColor: UIColor? {
        set {
            self.layer.shadowColor = newValue!.cgColor
        }
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor:color)
            }
            else {
                return nil
            }
        }
    }

    /* The opacity of the shadow. Defaults to 0. Specifying a value outside the
    * [0,1] range will give undefined results. Animatable. */
    @IBInspectable var shadowOpacity: Float {
        set {
            self.layer.shadowOpacity = newValue
        }
        get {
            return self.layer.shadowOpacity
        }
    }

    /* The shadow offset. Defaults to (0, -3). Animatable. */
    @IBInspectable var shadowOffset: CGPoint {
        set {
            self.layer.shadowOffset = CGSize(width: newValue.x, height: newValue.y)
        }
        get {
            return CGPoint(x: layer.shadowOffset.width, y:layer.shadowOffset.height)
        }
    }

    /* The blur radius used to create the shadow. Defaults to 3. Animatable. */
    @IBInspectable var shadowRadius: CGFloat {
        set {
            self.layer.shadowRadius = newValue
        }
        get {
            return self.layer.shadowRadius
        }
    }
*/
 
 }
    
extension UIButton{
    func flash (){
        let flash = CABasicAnimation(keyPath: "transform.scale")
        flash.duration = 0.6
        flash.fromValue = 0.75
        flash.toValue = 1.5
        flash.autoreverses = true
        flash.repeatCount = 10
        layer.add(flash, forKey: nil)
    }
}
extension UIImageView{
    func flash (){
        let flash = CABasicAnimation(keyPath: "transform.scale")
        flash.duration = 0.6
        flash.fromValue = 0.75
        flash.toValue = 1.5
        flash.autoreverses = true
        flash.repeatCount = 2000
        layer.add(flash, forKey: nil)
    }
}
// self.showActivityIndicator(indicator: self.indicator, startIndicator: true)
//  let indicator = NVActivityIndicatorView(frame: .zero, type: .ballRotateChase, color: .label, padding: 0)
//   Shared.showMessage(message: "Added To Cart Successfully!", error: false)

extension UIViewController{
    func showActivityIndicator(indicator: NVActivityIndicatorView? ,startIndicator: Bool){
        guard let indicator = indicator else {return}
        DispatchQueue.main.async {
            indicator.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(indicator)
            
            NSLayoutConstraint.activate([
                indicator.widthAnchor.constraint(equalToConstant: 40),
                indicator.heightAnchor.constraint(equalToConstant: 40),
                indicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ])
            if startIndicator{
                indicator.startAnimating()
            }else{
                indicator.stopAnimating()
            }
        }
      
    }
    func alert (title:String,message:String){
         let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
         self.present(alert, animated: true, completion: nil)
     }
    func indecator (indicator:NVActivityIndicatorView, check:Bool) {         
             self.showActivityIndicator(indicator: indicator, startIndicator: check)
     }
}

enum Alert:String {
    case sorry = "Sorry"
    case Done = "Done"
    case emptyFillData = "you must fill all data "
    case weakPassword = "The password must be 6 characters long or more"
    case failEmail = "The email address is already in use by another account or The email address is badly formatted"
    case registerPasswordWeak = "you are register now but be careful your password is very weak"
    case suucefulRegister = "You are register now  "
    case wrongLogin = "This Email or pass is wrongs "
    case LoginFirst = "You must Login first"
    case Reapted = " you are add it before"
}



func getDataFromFirebase (collection:String,userId:String,arrayOfField:[String],completion:@escaping ([Favourite])->()) {
    
    var arrayofAppending  = [Favourite]()
    let db = Firestore.firestore()
    db.collection(collection).document(userId).collection("all information").getDocuments { (snapshot, error) in
                
        if error == nil && snapshot != nil {
            arrayofAppending.removeAll()
            for document in snapshot!.documents {
                let singleData = Favourite(valueArrayName: (document.data()[arrayOfField[0]] as! String), valueArrayPrice: (document.data()[arrayOfField[1]] as! String), valueArrayImage: (document.data()[arrayOfField[2]] as! String))
                arrayofAppending.append(singleData)

    }
            completion(arrayofAppending)
        }
        
    }
}


func deleteFromFirebase (userId:String,productId:Int,collection:String) {
    let db = Firestore.firestore()
    db.collection(collection).document(userId).collection("all information").document("\(productId)").delete{ (error) in
        if error == nil {
            UserDefaults.standard.set(0, forKey: "fill")
            print("delete is done ")
        } else {
            print("delete is not done ")
        }
    }
}



