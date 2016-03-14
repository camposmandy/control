//
//  ViewController.swift
//  control
//
//  Created by Amanda Campos on 04/02/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var arrayOpcoes = ["Orçamento Limitado", "Orçamento ilimitado", "Lista de gastos"]

    @IBOutlet weak var labelInicial: UILabel!
    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var buttonLimitado: UIButton!
//    @IBOutlet weak var buttonIlimitado: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //Configurações da Navigation
        navigationController?.navigationBarHidden = true
        
        //design dos botões iniciais
        labelInicial.layer.cornerRadius = 230/2
        labelInicial.layer.borderColor = UIColor.whiteColor().CGColor
        labelInicial.layer.backgroundColor = UIColor(red: 27/255, green: 188/255, blue: 155/255, alpha: 0.8).CGColor
        
        labelInicial.layer.shadowColor = UIColor.blackColor().CGColor
        labelInicial.layer.shadowOffset = CGSizeZero
        labelInicial.layer.shadowOpacity = 3
        labelInicial.layer.masksToBounds = false


//        buttonIlimitado.layer.cornerRadius = 90
//        buttonIlimitado.layer.borderColor = UIColor.whiteColor().CGColor
//        buttonIlimitado.layer.backgroundColor = UIColor(red: 27/255, green: 188/255, blue: 155/255, alpha: 0.8).CGColor
//        
//        buttonIlimitado.layer.shadowColor = UIColor.blackColor().CGColor
//        buttonIlimitado.layer.shadowOffset = CGSizeZero
//        buttonIlimitado.layer.shadowOpacity = 3
//        buttonIlimitado.layer.masksToBounds = false
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = true
        self.tabBarController?.tabBar.hidden = true
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOpcoes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ViewInicialTableViewCell = tableView.dequeueReusableCellWithIdentifier("celula", forIndexPath: indexPath) as! ViewInicialTableViewCell
        
        cell.nomeDaOpcao.text = self.arrayOpcoes[indexPath.row]
        
        return cell
        
    }
}

