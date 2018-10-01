//
//  ApiToken.swift
//  PoolMeUp
//
//  Created by MOHAMED on 7/3/18.
//  Copyright © 2018 MOHAMED. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit
/// Check if user authinticated  or not and navigate user for screen
class ApiToken {
    /**
     Navigate User To screen
     
     */
    class func logoutApp() {
        UserDefaults.standard.removeObject(forKey: "api_token")
        ApiToken.restartApp()
    }
    class func restartApp(){
        guard let window =  UIApplication.shared.keyWindow else{return}
        let sb = UIStoryboard(name: "Main", bundle: nil)
        var vc :UIViewController
        if getApiToken() == nil {
            // Skip Auth Screen
            vc = sb.instantiateInitialViewController()!
        }else{
            vc = sb.instantiateViewController(withIdentifier: "HomeViewController")
        }
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
    }
    
    /**
     Save Api Token To cash
     - parameter token:  api_token value (string)
     
     */
    class func setApiToken(Token : String) {
        let api_token = UserDefaults.standard
        api_token.set(Token, forKey: "api_token")
        api_token.synchronize()
        restartApp()
    }
    
    /**
     get Api Token From cash
     <br/>
     it will return api_token value
     
     */
    class func getApiToken() ->String? {
        let api_token = UserDefaults.standard
        let obj =  api_token.object(forKey: "api_token")
        return obj as? String
    }
    
    class func GetLevel() -> String? {
        let api_token = UserDefaults.standard
        let level = api_token.object(forKey: "level")
        return level as? String
        
    }
    class func SetItems(Key : String! , Value : String!) {
        
        let Item = UserDefaults.standard
        Item.set(Value, forKey: Key )
        
    }
    // Get String Value From User Default
    class func GetItem(Key : String!) -> String!{
        let item = UserDefaults.standard
        if let obj = item.object(forKey: Key) {
            return obj as? String
        } else {
            return ""
        }
        
    }
    
}
