//
//  UIView+Extension.swift
//  Merita
//
//  Created by Abo Saleh on 03/07/2022.
//

import Foundation
import UIKit
import SwiftMessages
import NVActivityIndicatorView

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
}
