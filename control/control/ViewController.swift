//
//  ViewController.swift
//  control
//
//  Created by Amanda Campos on 04/02/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UIButton!
    
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        label.layer.cornerRadius = 75
        label.layer.borderColor = UIColor.whiteColor().CGColor
        label.layer.backgroundColor = UIColor(red: 27/255, green: 188/255, blue: 155/255, alpha: 0.8).CGColor
        
        label.layer.shadowColor = UIColor.blackColor().CGColor
        label.layer.shadowOffset = CGSizeZero
        label.layer.shadowOpacity = 3
        label.layer.masksToBounds = false
            
        button.layer.cornerRadius = 75
        button.layer.borderColor = UIColor.whiteColor().CGColor
        button.layer.backgroundColor = UIColor(red: 27/255, green: 188/255, blue: 155/255, alpha: 0.8).CGColor
        
        button.layer.shadowColor = UIColor.blackColor().CGColor
        button.layer.shadowOffset = CGSizeZero
        button.layer.shadowOpacity = 3
        button.layer.masksToBounds = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

