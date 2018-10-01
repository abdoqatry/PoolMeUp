//
//  Constants.swift
//  PoolMeUp
//
//  Created by MOHAMED on 7/3/18.
//  Copyright © 2018 MOHAMED. All rights reserved.
//

import Foundation
/// url to connect server

let ServerUrl = "http://tech.techno-hat.com/pool/public/"
/// access to server api
let MainUrl = ServerUrl + "api/"
/// url to login to app with email or phone and password
let LoginUrl = MainUrl + "passenger/login"

/// get all trips for passenger
let GetAllTripsUrl = MainUrl + "passenger/alltrip"
/// url to update user data
let UpdateUserAccountUrl = MainUrl + "update/account"

let GetPassngerTripsUrl = MainUrl + "passenger/mytrippassenger"
let PassengerBookingUrl = MainUrl + "passenger/addpassengerrequest"
let PassengerStartTripUrl = MainUrl + "passenger/movedpassenger"
let PassengerArrivedUrl = MainUrl + "passenger/accesspassenger"
let PassengetSuggestUrl = MainUrl + "passenger/showmysuggestions"
let AddPassengerSuggestUrl = MainUrl + "passenger/addsuggestions"

