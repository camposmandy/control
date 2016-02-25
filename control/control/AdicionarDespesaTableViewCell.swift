//
//  AdicionarDespesaTableViewCell.swift
//  control
//
//  Created by Mariana Medeiro on 25/02/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

class AdicionarDespesaTableViewCell: UITableViewCell {

    @IBOutlet weak var DescriçãoDespesaTxtField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureAdicionarDespesa(text: String?, placeholder: String){
        
        DescriçãoDespesaTxtField.text = text
        DescriçãoDespesaTxtField.placeholder = placeholder
        DescriçãoDespesaTxtField.accessibilityValue = text
        DescriçãoDespesaTxtField.accessibilityLabel = placeholder
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}