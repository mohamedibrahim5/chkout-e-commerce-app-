//
//  meWashListTableViewCell.swift
//  Merita
//
//  Created by mohamed ibrahim on 07/07/2022.
//

import UIKit

class meWashListTableViewCell: UITableViewCell {

    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nameOfProduct: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
