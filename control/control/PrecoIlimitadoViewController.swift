//
//  PrecoIlimitadoViewController.swift
//  control
//
//  Created by Amanda Campos on 11/03/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

class PrecoIlimitadoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let mm = ModeloMetodos()
    
    var arrayValores: Array<String> = []
    var arrayNomeItem: Array<String> = []
    var arrayValorInicial: Array<String> = []
    var arrayNomeLista: Array<String> = []
    
    var prod : Produtos!
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalDaComanda: UILabel!
    @IBOutlet weak var finalizarCompras: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBarHidden = false
        
        finalizarCompras.enabled = false
        
        mm.designBotao(totalDaComanda)
    }
    
    override func viewWillAppear(animated: Bool) {
    self.tabBarController?.tabBar.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayNomeItem.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCellWithIdentifier("celula", forIndexPath: indexPath) as! PrecoIlimitadoTableViewCell
        
        cell.nomeItemIlimitado.text = arrayNomeItem[indexPath.row]
        cell.precoItemIlimitado.text = arrayValores[indexPath.row]
        
        incrementar()
        
        if totalDaComanda.text != "R$"{
            finalizarCompras.enabled = true
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let maisUm = UITableViewRowAction(style: .Normal, title: "+1") { (action, index) -> Void in
            tableView.editing = false
            
            let v = self.arrayValorInicial.map{Float($0) ?? 0}
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
            
            self.prod = ProdutoManager.sharedInstance.novoProduto()
            self.prod.nome = descricaoTxtField.text
            self.prod.valor = Double(precoTxtField.text!)
            self.prod.lista = nil
            ProdutoManager.sharedInstance.save()
            
            self.arrayNomeItem.append(descricaoTxtField.text!)
            self.arrayValores.append(precoTxtField.text!)
            self.arrayValorInicial.append(precoTxtField.text!)
            
            self.navigationController?.popToViewController(self, animated: true)
            
            self.tableView.reloadData()
        })
        
        alertaNovoItem.addAction(cancelar)
        alertaNovoItem.addAction(salvar)
        
        self.presentViewController(alertaNovoItem, animated: true, completion: nil)
    }
    
    @IBAction func finalizarComanda(sender: AnyObject){
        mm.finalizarLista(navigationController!, view: self, arrayNomeLista: arrayNomeLista)
    }
    
    func incrementar(){
        var f = Float()
        var b = self.arrayValores.map{Float($0) ?? 0}
        
        for index in arrayValores{
            let c=b[arrayValores.indexOf(index)!]
            f = c+f
            
        }
        
        totalDaComanda.text = "\(f)"
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        }
//    }
    
}
