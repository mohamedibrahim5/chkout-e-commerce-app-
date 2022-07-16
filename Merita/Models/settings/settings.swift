//
//  settings.swift
//  Merita
//
//  Created by mohamed ibrahim on 16/07/2022.
//

import UIKit

class settings: UIViewController {
    var userId : String?

    @IBAction func currency(_ sender: UIButton) {
    }
    @IBAction func address(_ sender: Any) {
        
        let vc = UIStoryboard(name: "AdressMain", bundle: nil).instantiateViewController(withIdentifier: "addressmain") as? AdressMain
        vc!.userId = userId
        self.navigationController!.pushViewController(vc!, animated: true)
        
    }
    @IBAction func contactUsAction(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "https://www.facebook.com/shopify/")! as URL, options: [:], completionHandler: nil )
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
