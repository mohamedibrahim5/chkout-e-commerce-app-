//
//  meOrderCollectionViewCell.swift
//  Merita
//
//  Created by mohamed ibrahim on 16/07/2022.
//

import UIKit

class meOrderTableViewCell: UITableViewCell {
    @IBOutlet weak var adressOrder: UILabel!
    
    @IBOutlet weak var priceOrder: UILabel!
    
    @IBOutlet weak var dateOrder: UILabel!
    
    
    func configCell(address: String, Price: String, Date: String){
        self.adressOrder.text = address
        self.priceOrder.text = Price
        self.dateOrder.text = Date
    }
}
