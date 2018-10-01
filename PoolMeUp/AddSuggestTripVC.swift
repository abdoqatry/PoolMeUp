//
//  AddSuggestTripVC.swift
//  PoolMeUp
//
//  Created by MOHAMED on 7/10/18.
//  Copyright © 2018 MOHAMED. All rights reserved.
//

import UIKit
import CoreLocation
class AddSuggestTripVC: UIViewController {
    @IBOutlet weak var FromTime: UIButton!
    
    @IBOutlet weak var ToLocation: UIButton!
    @IBOutlet weak var FromLocation: UIButton!
    var PickeupLat : Double!
    var PickUpLong : Double!
    var PickUpDate : String!
    
    var DropOffLate : Double!
    var DropOffLong : Double!
    var DropOffDate : String!
    var fotmatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title =  "Add Suggested Trip"
        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func FromLocationButtonAction(_ sender: UIButton) {
        self.pickLocation { (lat, long) in
            self.getAddress(selectedLat: lat, selectedLon: long, handler: { (address) in
                
                sender.setTitle(address, for: .normal)
                self.PickeupLat = lat
                self.PickUpLong = long
            })
        }
    }
    
    @IBAction func ToLocationButtonAction(_ sender: UIButton) {
        self.pickLocation { (lat, long) in
            self.getAddress(selectedLat: lat, selectedLon: long, handler: { (address) in
                sender.setTitle(address, for: .normal)
                self.DropOffLate = lat
                self.DropOffLong = long
            })
        }
    }
    @IBAction func FromTimeButtonAction(_ sender: UIButton) {
        self.showTimePicker { (date) in
            self.fotmatter.dateFormat = "YYYY-MM-dd HH:mm"
            sender.setTitle(self.fotmatter.string(from: date), for: .normal)
            self.PickUpDate = self.fotmatter.string(from: date)
            

           
        }
    }
    
    @IBAction func ToTimeButtonAction(_ sender: UIButton) {
        self.showTimePicker { (date) in
            sender.setTitle(String(describing: date), for: .normal)
            self.fotmatter.dateFormat = "YYYY-MM-dd HH:mm"
            sender.setTitle(self.fotmatter.string(from: date), for: .normal)
           
            self.DropOffDate = self.fotmatter.string(from: date)
        }
    }
    
    
    
    
    
    
    @IBAction func AddSuggestTripButton(_ sender: UIButton) {
        let coordinate₀ = CLLocation(latitude: self.PickeupLat, longitude: self.PickUpLong)
        let coordinate₁ = CLLocation(latitude: self.DropOffLate, longitude: self.DropOffLong)
        
        let distanceInMeters = coordinate₀.distance(from: coordinate₁)
        let totalDistance = distanceInMeters/1000
        if let api_token = ApiToken.getApiToken() {
            ApiMethods.PassengerSuggestTrip(api_token: api_token, pick_up_longitude: String(self.PickUpLong), pick_up_latitude: String(self.PickeupLat), pick_off_longitude: String(self.DropOffLong), pick_off_latitude: String(self.DropOffLate), time_start: self.PickUpDate, time_end: self.DropOffDate, total_distance: String(totalDistance)){ (status, error, msg ) in
                if error == nil {
                    if status == true {
                        let alertView = UIAlertController(title: "", message: msg, preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                            self.dismiss(animated: true, completion: nil)
                        })
                        alertView.addAction(action)
                        self.present(alertView, animated: true, completion: nil)
                    }else {
                        ApiToken.restartApp()
                    }
                }
            }
        }
        
    }
    func getAddress(selectedLat : Double ,selectedLon : Double ,handler: @escaping (String) -> Void)
    {
        var address: String = ""
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: selectedLat, longitude: selectedLon)
        //selectedLat and selectedLon are double values set by the app in a previous process
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark?
            placeMark = placemarks?[0]
            
            // Address dictionary
            //print(placeMark.addressDictionary ?? "")
            
            // Location name
            if let locationName = placeMark?.addressDictionary?["Name"] as? String {
                address += locationName + ", "
            }
            
            // Street address
            if let street = placeMark?.addressDictionary?["Thoroughfare"] as? String {
                address += street + ", "
            }
            
            // City
            if let city = placeMark?.addressDictionary?["City"] as? String {
                address += city + ", "
            }
            
            // Zip code
            if let zip = placeMark?.addressDictionary?["ZIP"] as? String {
                address += zip + ", "
            }
            
            // Country
            if let country = placeMark?.addressDictionary?["Country"] as? String {
                address += country
            }
            
            // Passing address back
            handler(address)
        })
    }
}
