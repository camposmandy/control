//
//  DetalhesListaViewController.swift
//  control
//
//  Created by Mariana Medeiro on 17/03/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

class DetalhesListaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var produtos: [Produtos] = []
    var lista: Lista!
    var indice: Int!

    @IBOutlet weak var valorLimite: UILabel!
    @IBOutlet weak var valorGasto: UILabel!
    @IBOutlet weak var dataLista: UILabel!
    @IBOutlet weak var nomeLista: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        produtos = lista.produtos?.allObjects as! [Produtos]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return produtos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("celula", forIndexPath: indexPath) as! DetalheListaTableViewCell
        
        cell.nomeProduto.text = produtos[indexPath.row].nome
        cell.valorProduto.text = String(produtos[indexPath.row].valor)
        cell.qtdProduto.text = "\(produtos[indexPath.row].quantidade)"
        
        return cell
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
