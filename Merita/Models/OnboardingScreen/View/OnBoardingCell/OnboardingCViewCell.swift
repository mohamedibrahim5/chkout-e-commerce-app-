//
//  OnboardingCViewCell.swift
//  Merita
//
//  Created by Abo Saleh on 03/07/2022.
//

import UIKit

class OnboardingCViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnboardingCViewCell.self)
    
    @IBOutlet weak var slideImageView: UIImageView!
    
    @IBOutlet weak var slideTitleLbl: UILabel!
    
    @IBOutlet weak var slideDescriptionLbl: UILabel!


    func setup(_ slide: OnboardingSlide) {
        slideImageView.image = slide.image
        slideTitleLbl.text = slide.title
        slideDescriptionLbl.text = slide.description
    }

}
