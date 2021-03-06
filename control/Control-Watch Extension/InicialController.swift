//
//  InterfaceController.swift
//  Control-Watch Extension
//
//  Created by Mariana Medeiro on 18/03/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import WatchKit
import Foundation


class InicialController: WKInterfaceController {

    @IBOutlet var labelBemVindo: WKInterfaceLabel!
    @IBOutlet var gastoFixo: WKInterfaceButton!
    @IBOutlet var gastoIlimitado: WKInterfaceButton!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    

}
