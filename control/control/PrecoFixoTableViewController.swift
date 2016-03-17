//
//  PrecoFixoTableViewController.swift
//  control
//
//  Created by Amanda Campos on 05/02/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

class PrecoFixoTableViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var lista: Lista!
    var produto: Produtos!
    var mm = ModeloMetodos()
    var produtos:[Produtos] = []
    var precoFake = String()
    var arrayNomeLista: Array<String> = []

    @IBOutlet weak var nomeDaComanda: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var precoEscolhido: UILabel!
    @IBOutlet weak var buttonAddItem: UIBarButtonItem!
    @IBOutlet weak var buttonFinalizarItem: UIBarButtonItem!
    
    
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
            
            
            self.produto = ProdutoManager.sharedInstance.novoProduto()
            
            self.produto.nome = descricaoTxtField.text
            self.produto.valor = Double(precoTxtField.text!)
            self.produto.quantidade = 1
            self.produto.lista = self.lista
            
            ProdutoManager.sharedInstance.save()
            
            self.produtos.append(self.produto)
            
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
        valorDoLimite()
        
        //botão adc item e finalizar lista hidden
        buttonFinalizarItem.enabled = false
        buttonAddItem.enabled = false
        
        self.lista = ListaManager.sharedInstance.novaLista()
        self.lista.nome = nil

        mm.designBotao(precoEscolhido)
    }

    //conf. tabBar
    override func viewWillAppear(animated: Bool) { self.tabBarController?.tabBar.hidden = true }
    
    override func viewWillDisappear(animated: Bool) { self.tabBarController?.tabBar.hidden = false }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
     func numberOfSectionsInTableView(tableView: UITableView) -> Int { return 1 }

     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return produtos.count }

     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: PrecoFixoDetalhesTableViewCell = tableView.dequeueReusableCellWithIdentifier("celula", forIndexPath: indexPath) as! PrecoFixoDetalhesTableViewCell

        cell.descricaoLabel.text = produtos[indexPath.row].nome
        cell.precoLabel.text = "\(produtos[indexPath.row].valor)"
        
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
            
            self.lista.limite = Double(self.precoFake)

            self.navigationController?.popToViewController(self, animated: true)
        })
        
        alertaNovoLimite.addAction(cancelar)
        alertaNovoLimite.addAction(salvar)
        
        self.presentViewController(alertaNovoLimite, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let maisUm = UITableViewRowAction(style: .Normal, title: "+1") { (action, index) -> Void in
            tableView.editing = false

        var valor = self.produtos[indexPath.row].valor
        var quantidade = self.produtos[indexPath.row].quantidade
        
        valor = Double(valor!) / Double(quantidade!)
        quantidade = Double(quantidade!) + 1
        valor = Double(valor!) * Double(quantidade!)
        
        self.produtos[indexPath.row].valor = valor
        ProdutoManager.sharedInstance.save()
        
            self.tableView.reloadData()
        }
        
        maisUm.backgroundColor = UIColor(colorLiteralRed: 91/255, green: 59/255, blue: 128/255, alpha: 1)
        
        return [maisUm]
    }
    
    @IBAction func finalizar(sender: AnyObject) { mm.finalizarLista(navigationController!, view: self, arrayNomeLista: arrayNomeLista, lista: self.lista, tipo: "limitado") }
    
    func decrementar(){
        
        let valorInicial = Double(precoFake)
        var valorInicialAlterado = valorInicial
        for i in produtos{
            valorInicialAlterado = valorInicialAlterado! - Double(i.valor!)
        }
        
        precoEscolhido.text = "\(valorInicialAlterado)"
    }

    // MARK: - Navigation
//     In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//    }
}
