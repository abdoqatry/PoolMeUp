//
//  ApiMethods.swift
//  PoolMeUp
//
//  Created by MOHAMED on 7/3/18.
//  Copyright © 2018 MOHAMED. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
/// This class is responsible for all methods that connected to server

class ApiMethods {
    /// Update One Signal
    /**
     Update One Signal Token value on server .
     <br/>
     <ul >
     <lo>
     Parameter :
     <ul>
     <li>
     1- api_token : value that allows server to auth that user
     </li>
     <li>
     2- token : it's value requested from OneSignal platform
     
     </li>
     
     </ul>
     </lo>
     <lo>
     Description : That allows app to update onesignal platform playerid value (device will receive notifications) and the method is (post)
     </lo>
     </ul>
     */
    public class func AddOneSignalToken(api_token : String , token : String) {
        
        let parameters = [
            
            "api_token" : api_token ,
            "onesignal_id" : token ,
            
            ]
        let url = URL(string: UpdateUserAccountUrl)!
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .failure(let myerror) :
                print(myerror)
                let error = JSON(myerror)
                print(error)
                
            case .success(let value):
                let json = JSON(value)
                print(json)
                
            }
        }
    }
    // MARK: This is Login ith Email Function
    
    /**
     Login With Username and Password Function .
     <br/>
     <ul >
     <lo>
     Parameter :
     <ul>
     <li>
     1- name : Username Value (user credentials)
     </li>
     <li>
     2- password : Password Value (user credentials)
     
     </li>
     
     </ul>
     </lo>
     <lo>
     Description :
     That Allows User With his credentials To access app and the method is (post)
     </lo>
     </ul>
     */
    
    public class func LoginUser(email : String , password : String ,compltion : @escaping (_ status: Bool?,_ message:String? , _ error: Error?)->Void) {
        let parameters = [
            "emailorphone" : email ,
            "password" : password
        ]
        let url = URL(string: LoginUrl)
        Alamofire.request(url!, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            switch response.result {
            case .failure(let error) :
                let json = JSON(error)
                print("JSon" , json)
                print("Error" , error)
                compltion(false, nil , error)
                return
            case .success(let value) :
                let json = JSON(value)
                print("JSon" , json)
                var msg = ""
                if let message = json["message"].string {
                    msg = message
                }
                let status = json["status"].bool
                if let result = json["passenger"].dictionary {
                    if let id = result["id"]?.int {
                        ApiToken.SetItems(Key: "id", Value: String(describing: id))
                        
                    }
                    if let first_name = result["first_name"]?.string {
                        ApiToken.SetItems(Key: "first_name", Value: first_name)
                        
                    }
                    if let last_name = result["last_name"]?.string {
                        ApiToken.SetItems(Key: "last_name", Value: last_name)
                        
                    }
                    
                    if let api_token = json["api_token"].string{
                        ApiToken.setApiToken(Token: api_token )
                        print("Api Token" , api_token)
                    }
                    if let updated_at = result["updated_at"]?.string {
                        ApiToken.SetItems(Key: "last_login", Value: updated_at)
                    }
                }
                
                
                
                compltion(status, msg, nil)
                return
                
            }
        }
    }
    
    // MARK: This is Get All Trips For Passenger Function
    
    /**
     Get All Trips For Passenger Function .
     <br/>
     <ul >
     <lo>
     Parameter :
     <ul>
     <li>
     1- api_token : value that allows server to auth that user
     </li>
     <li>
     2- page : value to load next page for this list (pagination)
     
     </li>
     
     </ul>
     </lo>
     <lo>
     Description :
     That Allows User To Load All trips
     </lo>
     </ul>
     */
    class func GetAllTrips(page : Int = 1 , api_token : String ,compltion : @escaping (_ status: Bool?, _ error: Error? , _ last_page : Int? , _ trips : [AllTripsModel]? , _ api_token_status : Bool?)->Void) {
        let parameters = [
            "api_token" : api_token ,
            "page" : page
            
            ] as [String : Any]
        let url = URL(string: GetAllTripsUrl)
        Alamofire.request(url!, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            switch response.result {
            case .failure(let error) :
                let json = JSON(error)
                print("Error" , error)
                compltion(false , error , nil , nil , false)
                return
            case.success(let value):
                let json = JSON(value)
                print("Value" , value)
                var trips = [AllTripsModel]()
                let status = json["status"].bool
                let api_token_status = json["api_token_status"].bool
                if let Trips = json["trips"].dictionary {
                    if let data = Trips["data"]?.array {
                        for obj in data {
                            if let obj = obj.dictionary {
                                let trip = AllTripsModel(List: obj)
                                
                                trips.append(trip)
                            }
                        }
                      
                    }
                }
                let last_page = json["last_page"].int ?? page
                compltion(status,nil , last_page, trips , api_token_status)
                break
                return
            
                
            }
            
        }
    }
    // MARK: This is Get Trips For Passenger Function
    
    /**
     Get All Trips For Passenger Function .
     <br/>
     <ul >
     <lo>
     Parameter :
     <ul>
     <li>
     1- api_token : value that allows server to auth that user
     </li>
     <li>
     2- page : value to load next page for this list (pagination)
     
     </li>
     
     </ul>
     </lo>
     <lo>
     Description :
     That Allows User To Load passenger trips
     </lo>
     </ul>
     */
    class func GetPassengerTrips(page : Int = 1 , api_token : String ,compltion : @escaping (_ status: Bool?, _ error: Error? , _ last_page : Int? , _ trips : [PassengerTripModel]?  , _ api_token_status : Bool?)->Void) {
        let parameters = [
            "api_token" : api_token ,
            "page" : page
            
            ] as [String : Any]
        let url = URL(string: GetPassngerTripsUrl)
        Alamofire.request(url!, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            switch response.result {
            case .failure(let error) :
                let json = JSON(error)
                print("Error" , error)
                compltion(false , error , nil , nil , false)
                return
            case.success(let value):
                print("Value Of Passenger Trips " , value)
                let json = JSON(value)
                let api_token_status = json["api_token_status"].bool

                var trips = [PassengerTripModel]()
                let status = json["status"].bool
                if let Trips = json["mybookingtrip"].dictionary {
                    if let data = Trips["data"]?.array {
                        for obj in data {
                            if let obj = obj.dictionary {
                                let trip = PassengerTripModel(List: obj)
                                
                                trips.append(trip)
                            }
                        }
                     
                    }
                }
                let last_page = json["last_page"].int ?? page
                compltion(status,nil , last_page, trips , api_token_status)
                break
                return
                
            }
            
        }
    }
    // MARK: This is Book Trip For Passenger Function
    
    /**
     // MARK: This is Book Trip For Passenger Function
     <br/>
     <ul >
     <lo>
     Parameter :
     <ul>
     <li>
     1- api_token : value that allows server to auth that user
     </li>
     
     
     </ul>
     </lo>
     <lo>
     Description :
     That Allows User To book trip
     </lo>
     </ul>
     */
    class func PassngerBookTrip(api_token : String , id : String,compltion : @escaping (_ status: Bool?, _ error: Error? ,_ msg : String? )->Void) {
        let parameters = [
            "api_token" : api_token ,
            "id" : id
            ] as [String : Any]
        let url = URL(string: PassengerBookingUrl)
        Alamofire.request(url!, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            switch response.result {
            case .failure(let error) :
                let json = JSON(error)
                print("Error" , error)
                compltion(false , error , nil )
                return
            case.success(let value):
                print("Value" , value)
                let json = JSON(value)
                let status = json["status"].bool
                let msg = json["message"].string
                // compltion(status,nil , "")
                compltion(status, nil, msg)
                break
                return
            }
            
        }
        
    }
    
    // MARK: This is Start Trip For Passenger Function
    
    /**
     // MARK: This is  Start Trip For Passenger Function
     <br/>
     <ul >
     <lo>
     Parameter :
     <ul>
     <li>
     1- api_token : value that allows server to auth that user
     </li>
     <li>
     2- id : Trip Id
     <li>
     
     </ul>
     </lo>
     <lo>
     Description :
     That Allows User To start trip
     </lo>
     </ul>
     */
    class func StartTrip(api_token : String , id : String,compltion : @escaping (_ status: Bool?, _ error: Error? ,_ msg : String? )->Void) {
        let parameters = [
            "api_token" : api_token ,
            "id" : id
            ] as [String : Any]
        let url = URL(string: PassengerStartTripUrl)
        Alamofire.request(url!, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            switch response.result {
            case .failure(let error) :
                let json = JSON(error)
                print("Error" , error)
                compltion(false , error , nil )
                return
            case.success(let value):
                print("Value" , value)
                let json = JSON(value)
                let status = json["status"].bool
                let msg = json["message"].string
                // compltion(status,nil , "")
                compltion(status, nil, msg)
                break
                return
            }
            
        }
        
    }
    
    // MARK: This is  Passenger Arrived Function
    
    /**
     // MARK: This is  Passenger Arrived Function
     <br/>
     <ul >
     <lo>
     Parameter :
     <ul>
     <li>
     1- api_token : value that allows server to auth that user
     </li>
     <li>
     2- id : Trip Id
     <li>
     
     </ul>
     </lo>
     <lo>
     Description :
     That Allows User To start trip
     </lo>
     </ul>
     */
    class func PassengerArrived(api_token : String , id : String,compltion : @escaping (_ status: Bool?, _ error: Error? ,_ msg : String? )->Void) {
        let parameters = [
            "api_token" : api_token ,
            "id" : id
            ] as [String : Any]
        let url = URL(string: PassengerArrivedUrl)
        Alamofire.request(url!, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            switch response.result {
            case .failure(let error) :
                let json = JSON(error)
                print("Error" , error)
                compltion(false , error , nil )
                return
            case.success(let value):
                print("Value" , value)
                let json = JSON(value)
                let status = json["status"].bool
                let msg = json["message"].string
                // compltion(status,nil , "")
                compltion(status, nil, msg)
                break
                return
            }
            
        }
        
    }
    // MARK: This is  Passenger Suggestes Trips Function
    
    /**
     // MARK: This is  Passenger Suggestes Trips Function
     <br/>
     <ul >
     <lo>
     Parameter :
     <ul>
     <li>
     1- api_token : value that allows server to auth that user
     </li>
   
     
     </ul>
     </lo>
     <lo>
     Description :
     That Allows User To start trip
     </lo>
     </ul>
     */
    class func GetPassengerSuggestedTrips(page : Int = 1 , api_token : String ,compltion : @escaping (_ status: Bool?, _ error: Error? , _ last_page : Int? , _ trips : [PassengerSuggestModel]? , _ api_token_status : Bool? )->Void) {
        let parameters = [
            "api_token" : api_token ,
            "page" : page
            
            ] as [String : Any]
        let url = URL(string: PassengetSuggestUrl)
        Alamofire.request(url!, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            switch response.result {
            case .failure(let error) :
                let json = JSON(error)
                print("Error" , error)
                compltion(false , error , nil , nil , false)
                return
            case.success(let value):
                print("Value Of Passenger Trips " , value)
                let json = JSON(value)
                var trips = [PassengerSuggestModel]()
                let status = json["status"].bool
                let api_token_status = json["api_token_status"].bool
                if let Trips = json["my_suggestions"].dictionary {
                    if let data = Trips["data"]?.array {
                        for obj in data {
                            if let obj = obj.dictionary {
                                let trip = PassengerSuggestModel(List: obj)
                                
                                trips.append(trip)
                            }
                        }
                       
                    }
                }
                let last_page = json["last_page"].int ?? page
                compltion(status,nil , last_page, trips , api_token_status)
                break
                return
                
            }
            
        }
    }
    
    // MARK: This is  Passenger Add Suggested Trip Function
    
    /**
     // MARK: This is  Passenger Add Suggested Trip Function
     <br/>
     <ul >
     <lo>
     Parameter :
     <ul>
     <li>
     1- api_token : value that allows server to auth that user
     </li>
     <li>
     2- pick_up_longitude : Pick Up Longitude Point
     </li>
     <li>
     3- pick_up_latitude : Pick Up latitude Point
     </li>
     <li>
     4- pick_off_longitude : Pick off Longitude Point
     </li>
     <li>
     5- pick_off_latitude : Pick Off latitude Point
     </li>
     <li>
     6- time_start : Trip Start Time
     </li>
     <li>
     7- time_end : Trip End Time
     </li>
     </ul>
     </lo>
     <lo>
     Description :
     That Allows User To Add Suggest Trip
     </lo>
     </ul>
     */
    class func PassengerSuggestTrip(api_token : String ,pick_up_longitude : String ,pick_up_latitude : String , pick_off_longitude: String ,  pick_off_latitude: String , time_start: String ,  time_end: String , total_distance :String  ,compltion : @escaping (_ status: Bool?, _ error: Error? ,_ msg : String? )->Void) {
        let parameters = [
            "api_token" : api_token ,
            "pick_up_longitude": pick_up_longitude ,
            "pick_up_latitude" : pick_up_latitude ,
            "pick_off_longitude" : pick_off_longitude ,
            "pick_off_latitude" : pick_off_latitude ,
            "time_start" : time_start ,
            "time_end" : time_end ,
            "total_distance" : total_distance,
            "name_pick_up" : "Test" ,
            "name_pick_off" : "Another Test"
            
            ] as [String : Any]
        let url = URL(string: AddPassengerSuggestUrl)
        Alamofire.request(url!, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            switch response.result {
            case .failure(let error) :
                let json = JSON(error)
                print("Error" , error)
                compltion(false , error , nil )
                return
            case.success(let value):
                print("Value" , value)
                let json = JSON(value)
                let status = json["status"].bool
                let msg = json["message"].string
                // compltion(status,nil , "")
                compltion(status, nil, msg)
                break
                return
            }
            
        }
        
    }
}

