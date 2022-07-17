//
//  OredrTVCell.swift
//  Merita
//
//  Created by Abo Saleh on 17/07/2022.
//

import UIKit

class OredrTVCell: UITableViewCell {

    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
