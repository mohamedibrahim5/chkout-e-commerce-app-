//
//  CVCellForCategoryItem.swift
//  Merita
//
//  Created by Abo Saleh on 05/07/2022.
//

import UIKit

class CVCellForCategoryItem: UICollectionViewCell {
    
    @IBOutlet weak var imageCategory: UIImageView!
    
    @IBOutlet weak var titleCategory: UILabel!
    
    
    func configureCategoryItemCell(imageCategory: String, titleCategory: String) {
        self.imageCategory.sd_setImage(with: URL(string:imageCategory ), placeholderImage: UIImage(named: "R2.png"))
        self.titleCategory.text = titleCategory
    }
    
}
