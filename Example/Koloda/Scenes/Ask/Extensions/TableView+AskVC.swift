//
//  TableView+AskVC.swift
//  Koloda
//
//  Created by Alex Cuello ortiz on 12/05/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit


extension AskViewController {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.row {
        case 0:
            return tableView.dequeueReusableCell(withIdentifier: "imageCell")!
        case 1:
            return tableView.dequeueReusableCell(withIdentifier: "titleCell")!
        case 2:
            return tableView.dequeueReusableCell(withIdentifier: "descriptionCell")!
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
            return 183
        default:
            return UITableViewAutomaticDimension
        }
        
    }
}
