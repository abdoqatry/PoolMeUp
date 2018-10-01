//
//  PassengerTipCell.swift
//  PoolMeUp
//
//  Created by MOHAMED on 7/5/18.
//  Copyright © 2018 MOHAMED. All rights reserved.
//

import UIKit

class PassengerTipCell: UITableViewCell {

    @IBOutlet weak var PickUpPoint: UILabel!
    
    @IBOutlet weak var DropOffPoint: UILabel!
    @IBOutlet weak var StartTime: UILabel!
    
    //@IBOutlet weak var EndTime: UILabel!
    
    @IBOutlet weak var TotalPrice: UILabel!
    
    @IBOutlet weak var StartTrip: UIButton!
    @IBOutlet weak var ViewTripButton: UIButton!
    
    func ConfigureCell (Trip : PassengerTripModel) {
        self.StartTime.text = Trip.startTime
    //    self.EndTime.text = Trip.endTime
        self.TotalPrice.text = Trip.totalPrice
    }
    
}
