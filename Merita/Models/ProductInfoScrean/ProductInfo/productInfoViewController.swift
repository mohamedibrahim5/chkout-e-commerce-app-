//
//  productInfoViewController.swift
//  Merita
//
//  Created by mohamed ibrahim on 03/07/2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase
import SDWebImage

class productInfoViewController: UIViewController {
    
    static var x : Int = 0
    var userId : String?
    var productid : String = "77306237093988"
    var price : String =  "1255"
    var name : String = "Adidass"
    var image : String = "https://images.ctfassets.net/hrltx12pl8hq/7yQR5uJhwEkRfjwMFJ7bUK/dc52a0913e8ff8b5c276177890eb0129/offset_comp_772626-opt.jpg?fit=fill&w=800&h=300"
    var productInfoArray =  Product()

    @IBAction func favourite(_ sender: UIButton) {
        if userId == nil {
            showAlertLogin()
        }else {
            let db = Firestore.firestore()
          let docRef = db.collection("FAV").document("\(userId!)").collection("all information").document("\(productid)")
          docRef.getDocument { (document, error) in
              if let document = document, document.exists {
                  print("add to favourite1")
                  let checkFovuritename = db.collection("FAV").document("\(self.userId!)").documentID
                  print(checkFovuritename)
                  if checkFovuritename == self.userId! {
                      let alert = UIAlertController(title: "Warning", message: "Are you want to remove this product from favourite ", preferredStyle: .alert)

                      let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                          let db = Firestore.firestore()
                         
                              sender.setImage(UIImage(systemName: "heart.slash"), for: .normal)
                          db.collection("FAV").document("\(self.userId!)").collection("all information").document("\(self.productid)").delete{ (error) in
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
                      print("add to favourite3")
                      db.collection("FAV").document("\(self.userId!)").collection("all information").document("\(self.productid)").setData(["price":self.price,"name":self.name,"image":self.image], merge: true)
                  }
              }
              else {
                      print("add to favourite4")
                      print("Document does not exist")
                  productInfoViewController.x = 1
                  sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                  db.collection("FAV").document("\(self.userId!)").collection("all information").document("\(self.productid)").setData(["price":self.price,"name":self.name,"image":self.image], merge: true)
              }
          }
        }
      
    }
    @IBOutlet weak var brandName: UILabel!
    @IBAction func addToCart(_ sender: UIButton) {
        print(userId!)
        print("add to cart")
    }
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
       if productInfoViewController.x == 1 {
           
        }
    }
    func doSomethingDependingOnWhoSent(_ sender: UIButton) {
        sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    }
}
extension productInfoViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "productinfocell", for: indexPath) as! productInfoCollectionViewCell
        cell.imageviewproduct.sd_setImage(with: URL(string: "https://images.ctfassets.net/hrltx12pl8hq/7yQR5uJhwEkRfjwMFJ7bUK/dc52a0913e8ff8b5c276177890eb0129/offset_comp_772626-opt.jpg?fit=fill&w=800&h=300"), placeholderImage: UIImage(named: "test.jpeg"))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width*0.99, height: self.view.frame.width*0.5)
    }
}
extension productInfoViewController {
    func showAlertLogin(){
        let alert = UIAlertController(title: "warning", message: "You must Login first", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
}



