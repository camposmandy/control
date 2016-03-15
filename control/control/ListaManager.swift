//
//  ListaManager.swift
//  control
//
//  Created by Mariana Medeiro on 15/03/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class ListaManager {
    
    static let sharedInstance = ListaManager()
    static let entityName:String = "Lista"
    
    lazy var manegedContext:NSManagedObjectContext = {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var c = appDelegate.managedObjectContext
        return c!
    }()
    
    
    private init(){}
    
    
    func novaLista()->Lista{
        return NSEntityDescription.insertNewObjectForEntityForName(ListaManager.entityName, inManagedObjectContext: manegedContext) as! Lista
    }
    
    func save(){
        do{
            try manegedContext.save()
            print("Salvou")
        }
        catch{
            print("Deu ruim")
        }
    }
}
