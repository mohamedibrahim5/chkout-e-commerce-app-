//
//  UIView+Extension.swift
//  Merita
//
//  Created by Abo Saleh on 03/07/2022.
//

import Foundation
import UIKit

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
     
    @IBInspectable var LeftAndRightRadius: CGFloat {
         get { return self.LeftAndRightRadius }
         set {
             self.layer.cornerRadius = newValue
             self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
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
    
