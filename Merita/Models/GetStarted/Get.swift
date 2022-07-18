//
//  Get.swift
//  Merita
//
//  Created by mohamed ibrahim on 19/07/2022.
//

import UIKit

class Get: UIViewController {
    @IBAction func Adding(_ sender: UIButton) {
        allowNotifcation()
    }
    
    @IBAction func AddNotifcation(_ sender: UIButton) {
        allowNotifcation()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func allowNotifcation () {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { grented, error in }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
