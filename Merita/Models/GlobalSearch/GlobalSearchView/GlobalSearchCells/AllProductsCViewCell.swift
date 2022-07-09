//
//  AllProductsCViewCell.swift
//  Merita
//
//  Created by Abo Saleh on 09/07/2022.
//

import UIKit

class AllProductsCViewCell: UICollectionViewCell {
    @IBOutlet weak var backgroundCell: UIView!
    
    @IBOutlet weak var imageProduct: UIImageView!
    
    @IBOutlet weak var nameProduct: UILabel!
    
    @IBOutlet weak var priceProduct: UILabel!
    @IBOutlet weak var rateProduct: UILabel!
    
    
    
    
    
    func configureAllProductCell(imageProduct: String, titleProduct: String, priceProduct: String)
    {
        
        self.nameProduct.text = titleProduct
        self.priceProduct.text = priceProduct
        self.imageProduct.sd_setImage(with: URL(string: imageProduct), placeholderImage: UIImage(named: "R2.png"))
    }
    
    
    
    
    
}
