//
//  AskViewController.swift
//  Koloda
//
//  Created by Alex Cuello ortiz on 12/05/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit


class AskViewController:UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var askButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.askButton.layer.cornerRadius = 8
        
        
    }
    
    @IBAction func askButtonPressed(_ sender: Any) {
        
//        print(self.titleTextField.text)
//        print(self.descriptionTextView.text)
    }
}
