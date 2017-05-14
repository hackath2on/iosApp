//
//  TableView+AskVC.swift
//  Koloda
//
//  Created by Alex Cuello ortiz on 12/05/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import Kingfisher

protocol LabelTextFieldCellProtocol {
    func textFieldDidChangeValue(sender: UITextField)
}
extension AskViewController {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.row {
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell") as! ImageCell
            
            
            cell.incidenceImageView.layer.cornerRadius = 8
            cell.incidenceImageView.layer.masksToBounds = true
            
            self.incidencePictureURL = Constants.incidenciesImageURLsStrings[Int(arc4random_uniform(UInt32(Constants.incidenciesImageURLsStrings.count)))]
            print(incidencePictureURL)
            let url = URL(string: self.incidencePictureURL)
            
            cell.incidenceImageView.kf.setImage(with: url)
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell") as! TitleTextFieldCell
            cell.descriptionTextField.delegate = self
            cell.labelTextFieldCellProtocol = self
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell") as! LocationCell
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return 300
        case 1:
            return 90
        case 2:
            return 90
        default:
            return UITableViewAutomaticDimension
        }
        
    }
}
