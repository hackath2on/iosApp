//
//  WelcomeViewController.swift
//  Koloda
//
//  Created by Alex Cuello ortiz on 13/05/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import Alamofire

class WelcomeViewController: UIViewController {

    
    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contractIDTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    var timer:Timer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginButton.titleLabel?.text = "Entrar"
        self.loginButton.layer.cornerRadius = 8
        
        
        
        Alamofire.request("https://randomuser.me/api/").responseJSON { (response) in
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(WelcomeViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func appearView(withView customView: UIView) {
        
        customView.alpha = 0
        customView.isHidden = true
        
        UIView.animate(withDuration: 2, animations: {
            customView.alpha = 1
        }, completion: {
            finished in
            customView.isHidden = false
        })

    }
    
    
    func hiddeView(withView customView: UIView) {
        
        customView.alpha = 1
        customView.isHidden = false
        
        UIView.animate(withDuration: 1.2, animations: {
            customView.alpha = 0
        }, completion: {
            finished in
            customView.isHidden = true
        })
            }

    @IBAction func loginButtonPressed(_ sender: Any) {
        
    }
}
