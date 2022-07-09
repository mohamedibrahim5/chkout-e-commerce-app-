//
//  ProtocolToPassProduct.swift
//  Merita
//
//  Created by Abo Saleh on 07/07/2022.
//

import Foundation
import UIKit

protocol PassProductsCategory{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, productsCategory: String)

}
