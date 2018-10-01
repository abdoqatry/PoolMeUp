//
//  MapViewVC.swift
//  PoolMeUp
//
//  Created by MOHAMED on 7/4/18.
//  Copyright © 2018 MOHAMED. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
class MapViewVC: UIViewController ,  MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var MapView: MKMapView!
    var locationmanager = CLLocationManager()
    var Picklatitude : Double!
    var Picklongtude : Double!
    var DropOffLat : Double!
    var DropOffLong : Double!
     let annotation = MKPointAnnotation()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.MapView.delegate = self
        // Do any additional setup after loading the view.
        locationmanager.delegate = self
        locationmanager.desiredAccuracy = kCLLocationAccuracyBest
        locationmanager.requestWhenInUseAuthorization()
        locationmanager.startUpdatingLocation()
    }

    @IBAction func Cancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print(locations)
        let userlocation : CLLocation = locations[0]
       // let latitude = userlocation.coordinate.latitude
       // let longtude = userlocation.coordinate.longitude
        let latDelta : CLLocationDegrees = 0.05
        let LongDelte :CLLocationDegrees = 0.05
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: LongDelte)
        let cordinate = CLLocationCoordinate2D(latitude: Picklatitude, longitude: Picklongtude)
        
        let region = MKCoordinateRegion(center: cordinate, span: span)
        print("Region" , region)
       
        annotation.coordinate = CLLocationCoordinate2D(latitude: Picklatitude, longitude: Picklongtude)
        MapView.addAnnotation(annotation)
        let dropAnnotation = MKPointAnnotation()
    dropAnnotation.coordinate = CLLocationCoordinate2D(latitude: DropOffLat, longitude: DropOffLong)
        MapView.addAnnotation(dropAnnotation)
       // MapView.setRegion(region, animated: true)
        self.drawLines()
        self.locationmanager.stopUpdatingLocation()

        
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        print("Line 85 is being called......start...")
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 4.0
        
        print("Line 85 is being called.......end..")
        return renderer
    }
    func drawLines () {
        let sourceLocation = CLLocationCoordinate2D(latitude:self.Picklatitude, longitude: self.Picklongtude)
        let destinationLocation = CLLocationCoordinate2D(latitude: self.DropOffLat , longitude: self.DropOffLong)
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        // 4.
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        // 5.
        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.title = "Pickup Point"
        
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        
        
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = "Drop off Point"
        
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
        // 6.
        self.MapView.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
        
        // 7.
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        
        // 8.
        directions.calculate {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                
                return
            }
            
            let route = response.routes[0]
            self.MapView.add((route.polyline), level: MKOverlayLevel.aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.MapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
    }
    
}
}
