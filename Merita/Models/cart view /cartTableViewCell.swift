//
//  cartTableViewCell.swift
//  Merita
//
//  Created by mohamed ibrahim on 14/07/2022.
//

import UIKit

class cartTableViewCell: UITableViewCell {
    var plus:(()->())?
    var mines:(()->())?
    
    @IBOutlet weak var total: UILabel!
    @IBAction func minesbutton(_ sender: UIButton) {
        mines?()
    }
    @IBAction func plusbutton(_ sender: UIButton) {
        plus?()
    }
    @IBOutlet weak var nameProduct: UILabel!
    
    @IBOutlet weak var priceProduct: UILabel!
    
    
    @IBOutlet weak var imageProduct: UIImageView!
   
    
    @IBOutlet weak var decreaseNumProductBtn: UIButton!
    
    
    @IBOutlet weak var increaseNumProductBtn: UIButton!
    
    @IBOutlet weak var numberProductInCell: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
