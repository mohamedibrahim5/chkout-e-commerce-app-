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
    
var arrayOfProducts : ProductCategory?
    
    static var x : Int = 0
    var productIdString : String?
    var userId : String?
    var productname : String?
    var productdis : String?
    var productvendor : String?
    var productId : Int?
    var productprice : String?
    var productimage : String?
    var productimages : [String]?
    var price : String =  "1255"
    var name : String = "Adidass"
    var image : String = "https://images.ctfassets.net/hrltx12pl8hq/7yQR5uJhwEkRfjwMFJ7bUK/dc52a0913e8ff8b5c276177890eb0129/offset_comp_772626-opt.jpg?fit=fill&w=800&h=300"
   

    @IBAction func favourite(_ sender: UIButton) {
        if userId == nil {
            showAlertLogin()
        }else {
            let db = Firestore.firestore()
          let docRef = db.collection("FAV").document("\(userId!)").collection("all information").document("\(productIdString!)")
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
                      print("add to favourite3")
                      db.collection("FAV").document("\(self.userId!)").collection("all information").document("\(self.productIdString!)").setData(["price":self.productprice!,"name":self.productName.text!,"image":self.productimage!], merge: true)
                  }
              }
              else {
                      print("add to favourite4")
                      print("Document does not exist")
                  productInfoViewController.x = 1
                  sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                  db.collection("FAV").document("\(self.userId!)").collection("all information").document("\(self.productIdString!)").setData(["price":self.productprice!,"name":self.productName.text!,"image":self.productimage!], merge: true)
              }
          }
        }

    }
    @IBOutlet weak var brandName: UILabel!
    @IBAction func addToCart(_ sender: UIButton) {
       // print(userId!)
        print("add to cart")
        print(productId!)
        print("koko")
        print(productIdString!)
    }
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        productname = (arrayOfProducts?.title)!
        productdis = (arrayOfProducts?.body_html)!
        productName.text = productname
        productDescription.text = productdis
        productvendor = (arrayOfProducts?.vendor)!
        brandName.text = productvendor
        productId = (arrayOfProducts?.id)
        productIdString = "\(productId!)"
        productprice = arrayOfProducts?.variants![0].price
        productPrice.text = ("\(productprice!)$")
        productimage = arrayOfProducts?.images![0].src
//        productimages?.append((arrayOfProducts?.images![0].src)!)
//        productimages?.append((arrayOfProducts?.images![1].src)!)
//        productimages?.append((arrayOfProducts?.images![2].src)!)
//        productimages?.append((arrayOfProducts?.images![3].src)!)
        productimages = ["\(arrayOfProducts?.images![0].src! ?? "")","\(arrayOfProducts?.images![1].src! ?? "")","\(arrayOfProducts?.images![2].src! ?? "")"]
        
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
        return productimages!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "productinfocell", for: indexPath) as! productInfoCollectionViewCell
        cell.imageviewproduct.sd_setImage(with: URL(string: "\(productimages![indexPath.row])"), placeholderImage: UIImage(named: "test.jpeg"))
        return cell
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: self.view.frame.width*0.99, height: self.view.frame.width*0.5)
//    }
}
extension productInfoViewController {
    func showAlertLogin(){
        let alert = UIAlertController(title: "warning", message: "You must Login first", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
}



