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
import  NVActivityIndicatorView

class productInfoViewController: UIViewController {
    @IBOutlet weak var pageControler: UIPageControl!
    
    @IBOutlet weak var rating: UILabel!
    var arrayOfProducts : ProductCategory?
    var productInfo:ProductInfo?
    
    static var x : Int = 0
    var productIdString : String?
    var userId : String?
    
   
    
    var productId : Int?
    var productprice : String?
    var productPriceDouble : Double?
    var productimage : String?
    var productimages : [String] = []
    var timer :Timer?
    var currentCellIndex = 0
    var checkHeart : Double = 0
    let indicator = NVActivityIndicatorView(frame: .zero, type: .ballSpinFadeLoader, color: .systemRed, padding: 0)
    @IBOutlet weak var favourite: UIButton!
    @IBAction func favourite(_ sender: UIButton) {
        addToFavourite()
        sender.flash()
    }
    @IBOutlet weak var brandName: UILabel!
    @IBAction func addToCart(_ sender: UIButton) {
        self.showActivityIndicator(indicator: self.indicator, startIndicator: true)
        print(productId!)
        print(productIdString!)
        if userId == nil {
            alert(title: Alert.sorry.rawValue, message: Alert.LoginFirst.rawValue)
        } else {
            let db = Firestore.firestore()
          let docRef = db.collection("Cart").document("\(userId!)").collection("all information").document("\(productIdString!)")
          docRef.getDocument { (document, error) in
              if let document = document, document.exists {
                  print("add to Cart")
                  let checkFovuritename = db.collection("Cart").document("\(self.userId!)").documentID
                  print(checkFovuritename)
                  if checkFovuritename == self.userId! {
                      self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                      self.alert(title: Alert.sorry.rawValue, message: Alert.Reapted.rawValue)
                  }
                  else {
                      print("add to Cart")
                      db.collection("Cart").document("\(self.userId!)").collection("all information").document("\(self.productIdString!)").setData(["price":self.productprice!,"name":self.productName.text!,"image":self.productimage!,"DouplePrice":self.productPriceDouble!], merge: true)
                  }
              }
              else {
                      print("add to Cart")
                      print("Document does not exist")
                  self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
                  self.scheduleNotifiction(title: "You Are Add It In Cart", identifir: "CartId")
                  db.collection("Cart").document("\(self.userId!)").collection("all information").document("\(self.productIdString!)").setData(["price":self.productprice!,"name":self.productName.text!,"image":self.productimage!,"productid":self.productId!,"DouplePrice":self.productPriceDouble!], merge: true)
              }
          }
        }
    }
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showActivityIndicator(indicator: self.indicator, startIndicator: true)
        pageControler.numberOfPages = (arrayOfProducts?.images!.count)!
        productName.text = (arrayOfProducts?.title)!
        productDescription.text = (arrayOfProducts?.body_html)!
        brandName.text = (arrayOfProducts?.vendor)!
        productPrice.text = ("\(arrayOfProducts?.variants![0].price! ?? "")$")
        for index in 0..<(arrayOfProducts?.images!.count)! {
            productimages.append("\(arrayOfProducts?.images![index].src! ?? "")")
        }
        
        
        
        
        productId = (arrayOfProducts?.id)
        productIdString = "\((arrayOfProducts?.id) ?? 0)"
        productprice = arrayOfProducts?.variants![0].price
        productPriceDouble = Double(productprice!)
        productimage = arrayOfProducts?.images![0].src
        
        
       

        statrtTimer()
        let rndomNumber = Double.random(in: 2...5)
        let finalRandomNumber = Double(round(10*rndomNumber)/10)
        rating.text = String(finalRandomNumber)
        self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
        
    }
  
    override func viewWillAppear(_ animated: Bool) {
        self.showActivityIndicator(indicator: self.indicator, startIndicator: true)
        self.checkHeart = Double(UserDefaults.standard.integer(forKey: "\(productId!)"))
        if self.checkHeart == productPriceDouble {
            favourite.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        self.showActivityIndicator(indicator: self.indicator, startIndicator: false)
    }
}






extension productInfoViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productimages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "productinfocell", for: indexPath) as! productInfoCollectionViewCell
        cell.imageviewproduct.sd_setImage(with: URL(string: "\(productimages[indexPath.row])"))
        return cell
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 375 /*self.view.frame.width*1*/, height:240 /*self.view.frame.height*0.3*/)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControler.currentPage = indexPath.row
    }
    func scheduleNotifiction(title:String,identifir:String){
        let content = UNMutableNotificationContent()
        content.title = title
        content.sound = .default
        content.badge = 0
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(1), repeats: false)
      let request = UNNotificationRequest(identifier: identifir, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    func statrtTimer(){
        timer = Timer.scheduledTimer(timeInterval: 200, target: self, selector: #selector(movToNextIndex), userInfo: nil, repeats: true)
    }
    @objc func movToNextIndex (){
        if currentCellIndex < 2 {
            currentCellIndex += 1
        } else {
            currentCellIndex = 0
        }
        
        collectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        pageControler.currentPage = currentCellIndex
        
    }
}



