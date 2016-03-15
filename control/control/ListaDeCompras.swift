//
//  ListaDeCompras.swift
//  control
//
//  Created by Mariana Medeiro on 14/03/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class ListaDeCompras: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    
    static let sharedInstance = ListaDeCompras()
    static let entityName: String = "ListaDeCompras"
    
    let coreData = CoreDataManager.sharedInstance
    
    //private init(){}
    
    
    func novaLista() -> control.ListaDeCompras {
        
        return NSEntityDescription.insertNewObjectForEntityForName(ListaDeCompras.entityName, inManagedObjectContext: coreData.managedObjectContext!) as! control.ListaDeCompras
    }
    
    
    func Lista() -> Array<control.ListaDeCompras>? {
        return coreData.fetchData(ListaDeCompras.entityName, predicate: NSPredicate(format: "TRUEPREDICATE")) as? Array <control.ListaDeCompras>
    }
    
    
    func Lista(predicate: NSPredicate) -> Array<control.ListaDeCompras>? {
        return coreData.fetchData(ListaDeCompras.entityName, predicate: predicate) as? Array<control.ListaDeCompras>
    }
    
    
    func salvar() {
        coreData.saveContext()
    }
    
    
    func deletar(ListaDeCompras: control.ListaDeCompras) {
        coreData.managedObjectContext?.deleteObject(ListaDeCompras)
    }
    
    func deletarTudo(){
        let allObjects: Array<control.ListaDeCompras> = self.Lista()!
        for item: control.ListaDeCompras in allObjects as Array<control.ListaDeCompras> {
            self.deletar(item)
        }
    }
    

}
