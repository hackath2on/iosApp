//
//  TitleTextFieldCell.swift
//  Koloda
//
//  Created by Alex Cuello ortiz on 14/05/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class TitleTextFieldCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionTextField: UITextField!
    
    var labelTextFieldCellProtocol:LabelTextFieldCellProtocol?
    
    
    func textFieldValueChanged(sender: UITextField) {
        labelTextFieldCellProtocol?.textFieldDidChangeValue(sender: sender)
    }
    
    
}
