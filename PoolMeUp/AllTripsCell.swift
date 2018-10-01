//
//  AllTripsCell.swift
//  PoolMeUp
//
//  Created by MOHAMED on 7/4/18.
//  Copyright © 2018 MOHAMED. All rights reserved.
//

import UIKit

class AllTripsCell: UITableViewCell {

    @IBOutlet weak var PickUpPoint: UILabel!
    
    @IBOutlet weak var DropOffPoint: UILabel!
    @IBOutlet weak var StartTime: UILabel!

    @IBOutlet weak var EndTime: UILabel!
    
    @IBOutlet weak var TotalPrice: UILabel!
    
    @IBOutlet weak var BookTripButton: UIButton!
    @IBOutlet weak var ViewTripButton: UIButton!
    var id : String!
    func ConfigureCell (Trip : AllTripsModel) {
        self.StartTime.text = Trip.startTime
        self.EndTime.text = Trip.endTime
        self.TotalPrice.text = Trip.totalPrice
        self.id =  String(Trip.id)
    }
    
 
}
