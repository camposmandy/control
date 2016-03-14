//
//  ListaDeCompras+CoreDataProperties.swift
//  control
//
//  Created by Mariana Medeiro on 14/03/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ListaDeCompras {

    @NSManaged var nomeLista: String?
    @NSManaged var dataCompra: NSDate?
    @NSManaged var possuiProduto: NSManagedObject?

}
