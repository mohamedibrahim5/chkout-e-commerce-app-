//
//  productInfoCollectionViewCell.swift
//  Merita
//
//  Created by mohamed ibrahim on 03/07/2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase
import SDWebImage
import  NVActivityIndicatorView
class productInfoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageviewproduct: UIImageView!
}


extension productInfoViewController {
    func addToFavourite() {
        self.showActivityIndicator(indicator: self.indicator, startIndicator: true)
        if userId == nil {
            alert(title: Alert.sorry.rawValue, message: Alert.LoginFirst.rawValue)
        }else {
            let db = Firestore.firestore()
          let docRef = db.collection("FAV").document("\(userId!)").collection("all information").document("\(productIdString!)")
            docRef.getDocument { [self] (document, error) in
              if let document = document, document.exists {
                  self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                  print("add to favourite1")
                  let checkFovuritename = db.collection("FAV").document("\(self.userId!)").documentID
                  print(checkFovuritename)
                  if checkFovuritename == self.userId! {
                      let alert = UIAlertController(title: "Warning", message: "Are you want to remove this product from favourite ", preferredStyle: .alert)

                      let okAction = UIAlertAction(title: "Ok", style: .default, handler: { [self] (action) in
                          let db = Firestore.firestore()
                          UserDefaults.standard.set(0, forKey: "\(productId!)")
                          self.favourite.setImage(UIImage(systemName: "heart.slash"), for: .normal)
                          db.collection("FAV").document("\(self.userId!)").collection("all information").document("\(self.productIdString!)").delete{ (error) in
                              if error == nil {
                                  print("delete is done ")
                              } else {
                                  print("delete is not done ")
                              }
                          }
                      })
                      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                      })
                      alert.addAction(okAction)
                      alert.addAction(cancelAction)
                      self.present(alert, animated: true)
                      print("add to favourite2")
                  }
                  else {
                      self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                      print("add to favourite3")
                      db.collection("FAV").document("\(self.userId!)").collection("all information").document("\(self.productIdString!)").setData(["price":self.productprice!,"name":self.productName.text!,"image":self.productimage!], merge: true)
                  }
              }
              else {
                  self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                      print("add to favourite4")
                      print("Document does not exist")
                  self.favourite.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                  self.scheduleNotifiction(title: "You Are Add It In Favourite", identifir: "FavId")
                  UserDefaults.standard.set(self.productId, forKey: "\(productId!)")
                  db.collection("FAV").document("\(self.userId!)").collection("all information").document("\(self.productIdString!)").setData(["price":self.productprice!,"name":self.productName.text!,"image":self.productimage!,"productid":self.productId!], merge: true)
              }
          }
        }
    }
}
