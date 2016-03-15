//
//  Produtos.swift
//  control
//
//  Created by Mariana Medeiro on 14/03/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class Produtos: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    
    static let sharedInstance = Produtos()
    static let entityName:String = "Produtos"
    
    let coreData = CoreDataManager.sharedInstance
    
   // private init(){}
    
    
    func novoProduto() -> control.Produtos {
        return NSEntityDescription.insertNewObjectForEntityForName(Produtos.entityName, inManagedObjectContext: coreData.managedObjectContext!) as! control.Produtos
    }
    
    
    func Produto() -> Array<control.Produtos>? {
        return coreData.fetchData(Produtos.entityName, predicate: NSPredicate(format: "TRUEPREDICATE")) as? Array<control.Produtos>
    }
    
    
    func Produto(predicate: NSPredicate) -> Array<control.Produtos>? {
        return coreData.fetchData(Produtos.entityName, predicate: predicate) as? Array<control.Produtos>
    }
    
    
    func salvar(){
        coreData.saveContext()
    }
    
    
    func deletar(Produtos: control.Produtos) {
        coreData.managedObjectContext?.deleteObject(Produtos)
    }
    
    
    func deletarTudo(){
        let allObjects: Array<control.Produtos> = self.Produto()!
        for item: control.Produtos in allObjects as Array<control.Produtos> {
            self.deletar(item)
        }
    }

}
