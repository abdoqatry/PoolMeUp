//
//  LoginVC.swift
//  PoolMeUp
//
//  Created by MOHAMED on 7/4/18.
//  Copyright © 2018 MOHAMED. All rights reserved.
//

import UIKit
/// Declare Login Screen For Passenger or Driver
class LoginVC: UIViewController {
    /**
     Login Button property
     */
    @IBOutlet weak var LoginButton: UIButton!
    /**
     Facebook Login Button property
     */
    @IBOutlet weak var FacebookButton: UIButton!
    /**
    google plus button property
     */
    @IBOutlet weak var gPlusButton: UIButton!
    /**
        Password Input property
     */
    @IBOutlet weak var PasswordText: UITextField!
    /**
     Phone Or e-mail Input property

     */
    @IBOutlet weak var PhoneOrMailText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    /**
     Action For Login Button :- if user enter email or phone and password for his account then hint login button there is respond will send to server with account credentials then user will navigate to app home screen if email or phone and password right
     
     */
    @IBAction func LoginActionBu(_ sender: UIButton) {
        ApiMethods.LoginUser(email: self.PhoneOrMailText.text!, password: self.PasswordText.text!) { (status, msg, error) in
        }
    }
    
    @IBAction func LoginWithFbActionBu(_ sender: UIButton) {
    }
    @IBAction func LoginWithGplusActionBu(_ sender: UIButton) {
    }
    

}
