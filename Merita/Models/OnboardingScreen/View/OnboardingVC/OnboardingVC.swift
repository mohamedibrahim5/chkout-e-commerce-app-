//
//  OnboardingVC.swift
//  Merita
//
//  Created by Abo Saleh on 03/07/2022.
//

import UIKit

class OnboardingVC: UIViewController {
    
    @IBOutlet weak var onboardingCV: UICollectionView!{
        didSet{
            onboardingCV.dataSource = self
            onboardingCV.delegate = self
        }
    }
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextBtn: UIButton!
    
    var slides: [OnboardingSlide] = []
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextBtn.setTitle("Get Started", for: .normal)
            } else {
                nextBtn.setTitle("Next", for: .normal)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        slides = [
            OnboardingSlide(title: "Explore many products", description: "Explore a variety of amazing products from different brands around the world.", image: #imageLiteral(resourceName: "Slide1")),
            OnboardingSlide(title: "Choose & checkout", description: "Choose your product and enjoy the offers and discounts that are always available٫", image: #imageLiteral(resourceName: "Slide2")),
            OnboardingSlide(title: "Instant World-Wide Delivery", description: "Your orders will be delivered instantly irrespective of your location around the world.", image: #imageLiteral(resourceName: "Slide3"))
        ]
        
        pageControl.numberOfPages = slides.count
        
    }
    
    
    
    @IBAction func nextBtnClicked(_ sender: UIButton) {
        
        if currentPage == slides.count - 1 {
            let controller = storyboard?.instantiateViewController(identifier: "HomeNC") as! UINavigationController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            UserDefaults.standard.hasOnboarded = true
            present(controller, animated: true, completion: nil)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            onboardingCV.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        
    }
    
}


extension OnboardingVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCViewCell.identifier, for: indexPath) as! OnboardingCViewCell
        cell.setup(slides[indexPath.row])
        return cell
        
    }
    
}

extension OnboardingVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
    
}
