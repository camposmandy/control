//
//  AdicionarDespesaTableViewController.swift
//  control
//
//  Created by Mariana Medeiro on 25/02/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

class AdicionarDespesaTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var contadorCelulas = 1
    var cellIdentifier = "Cell"
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var botaoAdicionar: UIButton!
//    var sing = IngredientesManager.IngManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        botaoAdicionar.layer.cornerRadius = 22.5
//        botaoAdicionar.clipsToBounds = true
        
    }

//    override func viewWillAppear(animated: Bool) {
//        sing.modoPrepArray.removeAll()
//    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contadorCelulas
    }
    
  
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:AdicionarDespesaTableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? AdicionarDespesaTableViewCell
        
        
        if(cell == nil){
            cell = AdicionarDespesaTableViewCell(style: UITableViewCellStyle.Subtitle,reuseIdentifier:cellIdentifier)
        }
        
        cell.DescriçãoDespesaTxtField.delegate = self
        
        cell.configureAdicionarDespesa("", placeholder: "\((indexPath.row + 1))° passo")
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            contadorCelulas--
            tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: indexPath.row, inSection: 0)], withRowAnimation: .Bottom)
        }
        tableView.reloadData()
    }


    @IBAction func adicionarCelula(sender: AnyObject) {
        
        contadorCelulas++
        
        self.tableView.beginUpdates()
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: contadorCelulas-1, inSection: 0)], withRowAnimation: .Left)
        
        self.tableView.endUpdates()
    }




}
