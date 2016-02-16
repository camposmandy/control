//
//  PrecoFixoTableViewController.swift
//  control
//
//  Created by Amanda Campos on 05/02/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

class PrecoFixoTableViewController: UITableViewController {

    var arrayItens: Array<String> = []
    @IBOutlet weak var precoEscolhido: UILabel!
    
    @IBAction func adicionarItem(sender: AnyObject) {
        let alertaNovoItem = UIAlertController(title: nil, message: "", preferredStyle: .Alert)
        var descricaoTxtField = UITextField()
        var precoTxtField = UITextField()
        
        alertaNovoItem.addTextFieldWithConfigurationHandler { (textField) -> Void in
            descricaoTxtField = textField
            textField.placeholder = "Nome do item"
            textField.keyboardType = .Default
        }
        
        alertaNovoItem.addTextFieldWithConfigurationHandler { (textField) -> Void in
            precoTxtField = textField
            textField.placeholder = "Valor"
            textField.keyboardType = .DecimalPad
        }
        
        alertaNovoItem.view.layer.shadowColor = UIColor.blackColor().CGColor
        alertaNovoItem.view.layer.shadowOffset = CGSizeZero
        alertaNovoItem.view.layer.shadowOpacity = 1
        
        let cancelar = UIAlertAction(title: "Cancelar", style: .Cancel, handler: nil)
        let salvar = UIAlertAction(title: "Salvar", style: .Default, handler: { (ACTION) -> Void in
            let formatarNumero = (precoTxtField.text)?.stringByReplacingOccurrencesOfString(",", withString: ".")
            print(formatarNumero)
            print(descricaoTxtField.text)
            
            self.arrayItens.append(descricaoTxtField.text!)
            
            print(self.arrayItens)
            
            self.navigationController?.popToViewController(self, animated: true)
            self.tableView.reloadData()
        })
        
        alertaNovoItem.addAction(cancelar)
        alertaNovoItem.addAction(salvar)
        
        self.presentViewController(alertaNovoItem, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBarHidden = false
        
        precoEscolhido.text = "20,00"
        
        precoEscolhido.shadowColor = UIColor.blackColor()
        precoEscolhido.shadowOffset = CGSizeZero
        
        precoEscolhido.layer.cornerRadius = 90/2
        precoEscolhido.layer.borderColor = UIColor.whiteColor().CGColor
        precoEscolhido.layer.backgroundColor = UIColor(red: 27/255, green: 188/255, blue: 155/255, alpha: 0.8).CGColor
        
        precoEscolhido.layer.shadowColor = UIColor.blackColor().CGColor
        precoEscolhido.layer.shadowOffset = CGSizeZero
        precoEscolhido.layer.shadowOpacity = 3
        precoEscolhido.layer.masksToBounds = false
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.arrayItens.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: PrecoFixoDetalhesTableViewCell = tableView.dequeueReusableCellWithIdentifier("celula", forIndexPath: indexPath) as! PrecoFixoDetalhesTableViewCell

        cell.descricaoLabel.text = self.arrayItens[indexPath.row]
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
