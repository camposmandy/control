//
//  PrecoFixoTableViewController.swift
//  control
//
//  Created by Amanda Campos on 05/02/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

class PrecoFixoTableViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var mm = ModeloMetodos()

    var precoFake = String()
    var arrayItens: Array<String> = []
    var arrayValores: Array<String> = []
    var arrayValoresInicial: Array<String> = []

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
            self.arrayValoresInicial.append(precoTxtField.text!)
            
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
        
//        let darkBlur = UIBlurEffect(style: UIBlurEffectStyle.Dark)
//        let blurView = UIVisualEffectView(effect: darkBlur)
        
 //       blurView.frame = viewBackGroudLimite.bounds
   //     viewBackGroudLimite.addSubview(blurView)
        
        //botão adc item e finalizar lista hidden
        buttonFinalizarItem.enabled = false
        buttonAddItem.enabled = false
        
        mm.designBotao(precoEscolhido)
        
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
                
                self.precoFake = limiteTxtField.text!
                self.precoEscolhido.text = limiteTxtField.text
                
                self.decrementar()
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
            
            let v = self.arrayValoresInicial.map{Float($0) ?? 0}
            let k = self.arrayValores.map{Float($0) ?? 0}
            
            var x = v[indexPath.row]
            let j = x/k[indexPath.row]
            
            if v[indexPath.row] != j * v[indexPath.row]{
            x = (x + k[indexPath.row])
            } else {
                x += x
            }
            
            self.arrayValores.insert("\(x)", atIndex: index.row)
            self.arrayValores.removeAtIndex(index.row + 1)
            
            self.tableView.reloadData()
        }
        
        maisUm.backgroundColor = UIColor(colorLiteralRed: 91/255, green: 59/255, blue: 128/255, alpha: 1)
        
        return [maisUm]
    }
    
    @IBAction func finalizar(sender: AnyObject) { mm.finalizarLista(navigationController!, view: self) }
    
    func decrementar(){
        var a = Float(self.precoFake)!
        
        var b = self.arrayValores.map{Float($0) ?? 0}
        
        for j in arrayValores{
            let c = b[arrayValores.indexOf(j)!]
            a = a - c
        }
        
        precoEscolhido.text = "\(a)"
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
}
