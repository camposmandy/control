//
//  ViewController.swift
//  control
//
//  Created by Amanda Campos on 04/02/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    

    @IBOutlet weak var buttonLimitado: UIButton!
    @IBOutlet weak var buttonIlimitado: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //Configurações da Navigation
        navigationController?.navigationBarHidden = true
        
        //design dos botões iniciais
        buttonLimitado.layer.cornerRadius = 90
        buttonLimitado.layer.borderColor = UIColor.whiteColor().CGColor
        buttonLimitado.layer.backgroundColor = UIColor(red: 27/255, green: 188/255, blue: 155/255, alpha: 0.8).CGColor
        
        buttonLimitado.layer.shadowColor = UIColor.blackColor().CGColor
        buttonLimitado.layer.shadowOffset = CGSizeZero
        buttonLimitado.layer.shadowOpacity = 3
        buttonLimitado.layer.masksToBounds = false
            
        buttonIlimitado.layer.cornerRadius = 90
        buttonIlimitado.layer.borderColor = UIColor.whiteColor().CGColor
        buttonIlimitado.layer.backgroundColor = UIColor(red: 27/255, green: 188/255, blue: 155/255, alpha: 0.8).CGColor
        
        buttonIlimitado.layer.shadowColor = UIColor.blackColor().CGColor
        buttonIlimitado.layer.shadowOffset = CGSizeZero
        buttonIlimitado.layer.shadowOpacity = 3
        buttonIlimitado.layer.masksToBounds = false
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

