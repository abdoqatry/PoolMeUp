//
//  DatePickerVC.swift
//  PoolMeUp
//
//  Created by MOHAMED on 7/10/18.
//  Copyright © 2018 MOHAMED. All rights reserved.
//

import UIKit

class DatePickerVC: UIViewController {
    var completion: ((_ value: Date) -> ())!

    @IBOutlet weak var PickDate: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    /**
     close screen
     */
    func hide() {
        self.dismiss(animated: true, completion: nil)
    }
    /**
     close screen
     */
    @IBAction func DismissBu(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    /**
     pass value to pervious screen
     */
    @IBAction func PickBu(_ sender: Any) {
        self.completion(self.PickDate.date)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

extension UIViewController {
    /**
     call Choose height of patient screen
     */
    func showDatePicker(completion: @escaping (_ value: Date) -> ()) {
        let sliderview = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DatePickerVC") as! DatePickerVC
        
        sliderview.completion = completion
        sliderview.modalPresentationStyle = .custom
        
        self.present(sliderview, animated: true, completion: nil)
    }
    
    
}
