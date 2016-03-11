//
//  PrecoFixoTableViewController.swift
//  control
//
//  Created by Amanda Campos on 05/02/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

class PrecoFixoTableViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var arrayItens: Array<String> = []
    var arrayValores: Array<String> = []

    @IBOutlet weak var nomeDaComanda: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var precoEscolhido: UILabel!
    @IBOutlet weak var buttonAddItem: UIBarButtonItem!
    @IBOutlet weak var buttonFinalizarItem: UIBarButtonItem!
    
   // @IBOutlet weak var viewBackGroudLimite: UIView!
    
    @IBAction func adcItem(sender: AnyObject) {
        
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
            self.arrayValores.append(precoTxtField.text!)
            
            print(self.arrayItens)
            print(self.arrayValores)
            
            self.navigationController?.popToViewController(self, animated: true)
            self.tableView.reloadData()
        })
        
        alertaNovoItem.addAction(cancelar)
        alertaNovoItem.addAction(salvar)
        
        self.presentViewController(alertaNovoItem, animated: true, completion: nil)
        
    }

    @IBAction func alterarLimite(sender: AnyObject) { valorDoLimite() }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBarHidden = false
        
        let darkBlur = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurView = UIVisualEffectView(effect: darkBlur)
        
 //       blurView.frame = viewBackGroudLimite.bounds
   //     viewBackGroudLimite.addSubview(blurView)
        
        //botão adc item e finalizar lista hidden
        buttonFinalizarItem.enabled = false
        buttonAddItem.enabled = false
        
        precoEscolhido.shadowColor = UIColor.blackColor()
        precoEscolhido.shadowOffset = CGSizeZero
        
        precoEscolhido.layer.cornerRadius = 125/2
        precoEscolhido.layer.borderColor = UIColor.whiteColor().CGColor
        precoEscolhido.layer.backgroundColor = UIColor(red: 27/255, green: 188/255, blue: 155/255, alpha: 0.8).CGColor
        
        precoEscolhido.layer.shadowColor = UIColor.blackColor().CGColor
        precoEscolhido.layer.shadowOffset = CGSizeZero
        precoEscolhido.layer.shadowOpacity = 3
        precoEscolhido.layer.masksToBounds = false
        
    }

    //conf. tabBar
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = true
        valorDoLimite()
    }
    
    override func viewWillDisappear(animated: Bool) { self.tabBarController?.tabBar.hidden = false }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
     func numberOfSectionsInTableView(tableView: UITableView) -> Int { return 1 }

     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return self.arrayItens.count }

     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: PrecoFixoDetalhesTableViewCell = tableView.dequeueReusableCellWithIdentifier("celula", forIndexPath: indexPath) as! PrecoFixoDetalhesTableViewCell

        cell.descricaoLabel.text = self.arrayItens[indexPath.row]
        cell.precoLabel.text = self.arrayValores[indexPath.row]
        
        print("array reload ", self.arrayValores)
        decrementar()
        
        return cell
    }


    //alterar limite
    func valorDoLimite(){
        let alertaNovoLimite = UIAlertController(title: nil, message: "Defina o limite", preferredStyle: .Alert)
        var limiteTxtField = UITextField()
        
        alertaNovoLimite.addTextFieldWithConfigurationHandler { (textField) -> Void in
            limiteTxtField = textField
            textField.placeholder = "Valor"
            textField.keyboardType = .DecimalPad
        }
        
        alertaNovoLimite.view.layer.shadowColor = UIColor.blackColor().CGColor
        alertaNovoLimite.view.layer.shadowOffset = CGSizeZero
        alertaNovoLimite.view.layer.shadowOpacity = 1
        
        let cancelar = UIAlertAction(title: "Cancelar", style: .Cancel, handler: nil)
        let salvar = UIAlertAction(title: "Salvar", style: .Default, handler: { (ACTION) -> Void in
            
            let formatarNumero = (limiteTxtField.text)?.stringByReplacingOccurrencesOfString(",", withString: ".")
            print(formatarNumero)
            print(limiteTxtField.text)
            
            if limiteTxtField.text == "0" || limiteTxtField.text == "" {
                self.buttonFinalizarItem.enabled = false
                self.buttonAddItem.enabled = false
                
                self.precoEscolhido.text = "R$"
            } else {
                self.buttonFinalizarItem.enabled = true
                self.buttonAddItem.enabled = true
                
                self.precoEscolhido.text = limiteTxtField.text
            }
            
            self.navigationController?.popToViewController(self, animated: true)
        })
        
        alertaNovoLimite.addAction(cancelar)
        alertaNovoLimite.addAction(salvar)
        
        self.presentViewController(alertaNovoLimite, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let maisUm = UITableViewRowAction(style: .Normal, title: "+1") { (action, index) -> Void in
            tableView.editing = false
            
            let v = self.arrayValores.map{Float($0) ?? 0}
            var x = v[indexPath.row]
            x += x
            
            self.arrayValores.insert("\(x)", atIndex: index.row)
            self.arrayValores.removeAtIndex(index.row + 1)
            
            print("array edit ", self.arrayValores)
//            self.decrementar()
            
            self.tableView.reloadData()
        }
        
        maisUm.backgroundColor = UIColor(colorLiteralRed: 91/255, green: 59/255, blue: 128/255, alpha: 1)
        
        return [maisUm]
    }
    
    func decrementar(){
       var a = Int(precoEscolhido.text!)
        print("inicial", a)
        
        for index in arrayValores{
        var b = self.arrayValores.map{Int($0) ?? 0}
        let y = b[arrayValores.indexOf(index)!]
            
            print(index)
            print(y)
            
            a = a! - y
            
            print("Final ", a)
        }
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
     func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
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
