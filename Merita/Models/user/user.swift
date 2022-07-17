//
//  user.swift
//  Merita
//
//  Created by mohamed ibrahim on 16/07/2022.
//

import UIKit
import MapKit
import CoreLocation
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase
import Firebase
class user: UIViewController, MKMapViewDelegate {
    var TotalPrice : Double?
    var userId : String?
    var name : String?
    var city : String?
    var country : String?

    let db = Firestore.firestore()
    @IBAction func addLocation(_ sender: UIButton) {
        db.collection("Adress").document(userId!).setData(["streat":name!,"city":city!,"country":country!])
        let vc = UIStoryboard(name: "ConfirmOrder", bundle: nil).instantiateViewController(withIdentifier: "confirm") as? ConfirmOrder
        vc!.userId = userId
        vc?.TotalPrice = TotalPrice
        vc?.checkAddress = "Temp"
        vc?.temp = "\(country!),\(city!),\(name!)"
        
        self.navigationController!.pushViewController(vc!, animated: true)
    }
    @IBOutlet weak var mapkit: MKMapView!
    var locationManger = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        mapkit.delegate = self
    }

    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        getLoc(location: CLLocation(latitude: mapkit.centerCoordinate.latitude, longitude: mapkit.centerCoordinate.longitude))
    }
    func getLoc (location:CLLocation) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { places, error in
            guard let place = places?.first,error == nil else {return}
           print("streat\(place.name ?? "")")
            print("country\(place.country ?? "")")
            print("city\(place.locality ?? "")")
            self.name = place.name ?? ""
            self.country = place.country ?? ""
            self.city = place.locality ?? ""
         //   print("name"\(place.name!))
        }
    }
    

}
