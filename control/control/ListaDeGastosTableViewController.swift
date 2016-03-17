//
//  ListaDeGastosTableViewController.swift
//  control
//
//  Created by Amanda Campos on 14/03/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

class ListaDeGastosTableViewController: UITableViewController {
    
    var arrayLista: Array<String> = []
    var arrayData: Array<String> = []
    var arrayTotal: Array<String> = []
    var listas: [Lista] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBarHidden = false
        
        listas = ListaManager.sharedInstance.buscarListas()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        for listaIndex in ListaManager.sharedInstance.buscarListas(){
            var soma: Double = 0
            print(listaIndex.nome)
            
            if  listaIndex.nome == nil {
                ListaManager.sharedInstance.delete(listaIndex)
                ListaManager.sharedInstance.save()
            } else {
                
                arrayLista.append(listaIndex.nome!)
                arrayData.append("\(listaIndex.data!)")
                for produtoIndex in ProdutoManager.sharedInstance.buscarProdutos(){
                    if produtoIndex.lista!.nome == listaIndex.nome{
                        let formatarNumero = ("\(produtoIndex.valor)").stringByReplacingOccurrencesOfString("Optional", withString: " ")
                        let formatarNumer = (formatarNumero).stringByReplacingOccurrencesOfString("(", withString: " ")
                        let formatarNum = (formatarNumer).stringByReplacingOccurrencesOfString(")", withString: " ")
                        
                        print("valor: ", formatarNum)
                        soma = soma + Double(produtoIndex.valor!)
                        print(soma)
                    }
                }
                arrayTotal.append("\(soma)")
            }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController!.popToRootViewControllerAnimated(true)
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listas.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("celula", forIndexPath: indexPath) as! ListaDeGastosTableViewCell

        cell.nomeDaLista.text = listas[indexPath.row].nome
        cell.totalDaLista.text = arrayTotal[indexPath.row]
        cell.dataDaLista.text = "\(listas[indexPath.row].data)"
        
        
        return cell
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Deletar lista
            for list in ListaManager.sharedInstance.buscarListas(){
                if list.nome == arrayLista[indexPath.row]{
                    arrayLista.removeAtIndex(indexPath.row)
                    ListaManager.sharedInstance.delete(list)
                    ListaManager.sharedInstance.save()
                }
            }
        }
        
        self.tableView.reloadData()
    }

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

// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if segue.identifier == "dadosLista" {
        let destino = segue.destinationViewController as! DetalhesListaViewController
        let cell = sender as! UITableViewCell
        let indexPath = self.tableView.indexPathForCell(cell)
        let objeto = listas[(indexPath?.row)!]
        destino.lista = objeto
        destino.indice = indexPath?.row
    }
    
    
}

}
