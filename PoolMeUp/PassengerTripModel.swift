//
//  PassengerTripModel.swift
//  PoolMeUp
//
//  Created by MOHAMED on 7/5/18.
//  Copyright © 2018 MOHAMED. All rights reserved.
//

import Foundation
import SwiftyJSON
class PassengerTripModel {
    var id : Int!
    var pickupLat : String!
    var pickupLang : String!
    var dropoffLat : String!
    var dropoffLang : String!
    var startTime : String!
    var endTime : String!
    var totalPrice : String!
    
    init(List : [String : JSON]) {
        if let ID = List["id"]?.int {
            self.id = ID
        }
        if let PickUpLat = List["pick_up_latitude_trip"]?.string {
            self.pickupLat = PickUpLat
        }
        if let PickUpLang = List["pick_up_longitude_trip"]?.string {
            self.pickupLang = PickUpLang
        }
        if let DropOffLat = List["pick_off_latitude_trip"]?.string {
            self.dropoffLat = DropOffLat
        }
        if let DropOffLang = List["pick_off_longitude_trip"]?.string {
            self.dropoffLang = DropOffLang
        }
        if let StartTime = List["time_start_trip"]?.string{
            self.startTime = StartTime
        }
        if let EndTime = List["time_end_trip"]?.string {
            self.endTime = EndTime
        }
        
        if let Total = List["fare_total"]?.string {
            self.totalPrice = Total
        }
    }
}

