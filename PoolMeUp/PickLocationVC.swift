//
//  PickLocationVC.swift
//  PoolMeUp
//
//  Created by MOHAMED on 7/9/18.
//  Copyright © 2018 MOHAMED. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
class PickLocationVC: UIViewController , MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var MapView: MKMapView!
    var locationmanager = CLLocationManager()
    var completion: ((_ lat: Double , _ long : Double) -> ())!
    var LocationLat : Double!
    var LocationLong : Double!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.MapView.delegate = self
        // Do any additional setup after loading the view.
        locationmanager.delegate = self
        locationmanager.desiredAccuracy = kCLLocationAccuracyBest
        locationmanager.requestWhenInUseAuthorization()
        locationmanager.startUpdatingLocation()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func PickLocationButton(_ sender: UIButton) {
        
        self.completion(LocationLat , LocationLong)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func AddPointToMap(_ sender: UILongPressGestureRecognizer) {
        let location = sender.location(in: self.MapView)
        let locCord = self.MapView.convert(location, toCoordinateFrom: self.MapView)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = locCord
        annotation.title = "Pick"
        self.MapView.removeAnnotations(self.MapView.annotations)
        self.MapView.addAnnotation(annotation)
        self.LocationLat = locCord.latitude
        self.LocationLong = locCord.longitude
        
    }
    
    
}
extension UIViewController {
    /**
     call Choose height of patient screen
     */
    func pickLocation(completion: @escaping (_ lat: Double , _ long : Double) -> ()) {
        let sliderview = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PickLocationVC") as! PickLocationVC
        
        sliderview.completion = completion
        sliderview.modalPresentationStyle = .custom
        
        self.present(sliderview, animated: true, completion: nil)
    }
    
    
}
