//
//  ModeloMetodos.swift
//  control
//
//  Created by Amanda Campos on 13/03/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

class ModeloMetodos: NSObject {

    func designBotao(preco: UILabel) {
        
        preco.shadowColor = UIColor.blackColor()
        preco.shadowOffset = CGSizeZero
        
        preco.layer.cornerRadius = 125/2
        preco.layer.borderColor = UIColor.whiteColor().CGColor
        preco.layer.backgroundColor = UIColor(red: 27/255, green: 188/255, blue: 155/255, alpha: 0.8).CGColor
        
        preco.layer.shadowColor = UIColor.blackColor().CGColor
        preco.layer.shadowOffset = CGSizeZero
        preco.layer.shadowOpacity = 3
        preco.layer.masksToBounds = false
    }
    
    func adicionarItemNaLista(var nomeItem: Array<String>, var valoresItens: Array<String>, var valoresIniciais: Array<String>, navigation: UINavigationController, view: UIViewController, tableView: UITableView){
        
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
            
            nomeItem.append(descricaoTxtField.text!)
            valoresItens.append(precoTxtField.text!)
            valoresIniciais.append(precoTxtField.text!)
            
            navigation.popToViewController(view, animated: true)
            
            tableView.reloadData()
        })
        
        alertaNovoItem.addAction(cancelar)
        alertaNovoItem.addAction(salvar)
        
        view.presentViewController(alertaNovoItem, animated: true, completion: nil)
    }
    
    func finalizarLista(navigation: UINavigationController, view: UIViewController){
        let alertaNovoLimite = UIAlertController(title: nil, message: "Digite um novo nome para sua comanda", preferredStyle: .Alert)
        var limiteTxtField = UITextField()
        
        alertaNovoLimite.addTextFieldWithConfigurationHandler { (textField) -> Void in
            limiteTxtField = textField
            textField.placeholder = "Nome da comanda"
            textField.keyboardType = .DecimalPad
        }
        
        alertaNovoLimite.view.layer.shadowColor = UIColor.blackColor().CGColor
        alertaNovoLimite.view.layer.shadowOffset = CGSizeZero
        alertaNovoLimite.view.layer.shadowOpacity = 1
        
        let cancelar = UIAlertAction(title: "Cancelar", style: .Cancel, handler: nil)
        let salvar = UIAlertAction(title: "Salvar", style: .Default, handler: { (ACTION) -> Void in
            
            //salvar no coreData e redirecionar para a lista
            
            navigation.popToViewController(view, animated: true)
        })
        
        alertaNovoLimite.addAction(cancelar)
        alertaNovoLimite.addAction(salvar)
        
        view.presentViewController(alertaNovoLimite, animated: true, completion: nil)
    }
}
