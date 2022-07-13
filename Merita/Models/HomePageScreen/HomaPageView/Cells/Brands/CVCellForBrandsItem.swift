//
//  CVCellForBrandsItem.swift
//  Merita
//
//  Created by Abo Saleh on 05/07/2022.
//

import UIKit
import SDWebImage

class CVCellForBrandsItem: UICollectionViewCell {
    
    
    @IBOutlet weak var imageForBrand: UIImageView!
    
    @IBOutlet weak var nameBrand: UILabel!
    
    
    func configureBrandItemCell(imageBrand: String, nameBrand: String) {
        self.imageForBrand.sd_setImage(with: URL(string:imageBrand ), placeholderImage: UIImage(named: "R2.png"))
        self.nameBrand.text = nameBrand
    }
    
}

