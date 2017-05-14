//
//  Firebase+AskVC.swift
//  Koloda
//
//  Created by Alex Cuello ortiz on 14/05/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON

extension BackgroundAnimationViewController {
    
    func getComplains() {
        
        FIRDatabase.database().reference().child("complains").observe(.value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? Dictionary<String,AnyObject> {
                let json = JSON(dictionary)
                
                let arrayJSON = json.dictionaryValue
                for (key,value) in arrayJSON {
                    self.complains.append(Complain(id: key, picture: value["image_url"].string!, description: value["title"].string!))
                }
                
                self.loaderIndicator.stopAnimating()
                self.kolodaView!.reloadData()
                
            }
        })
    }

}
