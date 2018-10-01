//
//  AllTripsVC.swift
//  PoolMeUp
//
//  Created by MOHAMED on 7/4/18.
//  Copyright © 2018 MOHAMED. All rights reserved.
//

import UIKit
import CoreLocation

class AllTripsVC: UIViewController ,UITableViewDelegate , UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    
    var Trips = [AllTripsModel]()
    var current_page :Int = 1
    var last_page : Int = 1
    var isLoading : Bool = false
    lazy var refresher : UIRefreshControl = {
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handelRefresh), for: .valueChanged)
        return refresher
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "All Trips"
        tableView.tableFooterView = UIView()
        tableView.separatorInset = .zero
        tableView.contentInset = .zero
        tableView.delegate = self
        tableView.dataSource = self
        tableView.addSubview(refresher)
        handelRefresh()
    }
   
    @objc private func handelRefresh() {
        self.refresher.endRefreshing()
        
        guard !isLoading else {return}
        
        isLoading = true
        if let api_token = ApiToken.getApiToken(){
            ApiMethods.GetAllTrips(api_token: api_token ) { (error, status, last_page ,trips , api_token_status)   in
                if api_token_status == true {
                    if let trips = trips {
                        
                        self.Trips = trips
                        
                        self.tableView.reloadData()
                        self.current_page = 1
                        
                        self.last_page = last_page!
                        
                        
                    }
                }else {
                    ApiToken.logoutApp()
                }
              
            }
            
        }
        
    }
    /**
     Load more records
     
     */
    func loadMore ()  {
        
        guard !isLoading else {return}
        
        guard current_page < last_page else {return}
        
        isLoading = true
        if let api_token = ApiToken.getApiToken(){
            ApiMethods.GetAllTrips(page : self.current_page ,api_token: api_token ) { (error, status, last_page ,trips ,api_token_status)   in
                if api_token_status == true {
                    if let trips = trips {
                        
                        self.Trips = trips
                        
                        self.tableView.reloadData()
                        
                        self.current_page += 1
                        
                        self.last_page = last_page!
                        
                    }
                }else {
                    ApiToken.logoutApp()
                }
             
            }
            
        }
        
        
        
    }
    /**
     Number of sction in tableview
     
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    /**
     Number Of Records
     
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.Trips.count
    }
    /**
     fetch each cell
     
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllTripsCell") as! AllTripsCell
        let trip = Trips[indexPath.row]
        cell.ViewTripButton.tag = indexPath.row
        cell.BookTripButton.tag = indexPath.row
        cell.ViewTripButton.addTarget(self, action: #selector(didTapButton(sender:)), for: .touchUpInside)
        cell.BookTripButton.addTarget(self, action: #selector(didTapButtonBook(sender:)), for: .touchUpInside)
        // Get Pickup Address Point
        self.getAddress(selectedLat: Double(trip.pickupLat!)!, selectedLon: Double(trip.pickupLang!)!) { (address) in
            cell.PickUpPoint.text = address
        }
        self.getAddress(selectedLat: Double(trip.dropoffLat!)!, selectedLon: Double(trip.dropoffLang!)!) { (address) in
            cell.DropOffPoint.text = address
        }
        cell.ConfigureCell(Trip: trip)
        
        return cell
    }
    // MARK: - Actions
    
    @objc func didTapButton(sender: UIButton) {
        let indexpath = IndexPath(row: sender.tag, section: 0)
        let cell = tableView.cellForRow(at: indexpath ) as! AllTripsCell
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MapViewVC") as! MapViewVC
        let item = Trips[indexpath.row]
        vc.Picklatitude = Double(item.pickupLat!)
        vc.Picklongtude = Double(item.pickupLang!)
        vc.DropOffLat = Double(item.dropoffLat!)
        vc.DropOffLong = Double(item.dropoffLang!)
        self.present(vc, animated: true, completion: nil)
    }
    @objc func didTapButtonBook(sender: UIButton) {
        let indexpath = IndexPath(row: sender.tag, section: 0)
        let cell = tableView.cellForRow(at: indexpath ) as! AllTripsCell
        if let api_token = ApiToken.getApiToken() {
            ApiMethods.PassngerBookTrip(api_token: api_token , id: cell.id) { (status, error, msg) in
                if error == nil {
                    if status == true {
                        let alertView = UIAlertController(title: "", message: msg, preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                            
                        })
                        alertView.addAction(action)
                        self.present(alertView, animated: true, completion: nil)
                    }else {
                        let alertView = UIAlertController(title: "", message: msg, preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                            
                        })
                        alertView.addAction(action)
                        self.present(alertView, animated: true, completion: nil)
                    }
                }
            }
        }
        
    }
    
    /**
     View more button action ( it will navigate to view more screen)
     
     */
 
    
    
    /**
     height for each cells
     
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 210.00;//Choose your custom row height
    }
    /**
     Get Location Address By giving latitude and longtude
     */
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


