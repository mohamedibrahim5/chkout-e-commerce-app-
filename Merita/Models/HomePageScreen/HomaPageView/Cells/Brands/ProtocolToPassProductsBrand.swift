//
//  ProtocolToPassProductsBrand.swift
//  Merita
//
//  Created by Abo Saleh on 11/07/2022.
//

import Foundation
import UIKit

protocol PassProductsBrand{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, productsBrandTitle: String)
    
}
