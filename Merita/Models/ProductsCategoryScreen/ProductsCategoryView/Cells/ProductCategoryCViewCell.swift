//
//  ProductCategoryCViewCell.swift
//  Merita
//
//  Created by Abo Saleh on 06/07/2022.
//

import UIKit

class ProductCategoryCViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundCell: UIView!
    
    @IBOutlet weak var imageProduct: UIImageView!
    
    @IBOutlet weak var titleProductLabel: UILabel!
    
    @IBOutlet weak var priceProductLabel: UILabel!
    
    @IBOutlet weak var ratingProductLabel: UILabel!
    
    @IBOutlet weak var currencyProductLabel: UILabel!
    
    
    func configureProductCategoryCell(imageProduct: String, titleProduct: String, priceProduct: String)
    {
        
        
        
       // self.backgroundCell.backgroundColor = UIColor.clear
        self.titleProductLabel.text = titleProduct
        self.priceProductLabel.text = priceProduct
        self.imageProduct.sd_setImage(with: URL(string: imageProduct), placeholderImage: UIImage(named: "R2.png"))
        
    }
    
}
