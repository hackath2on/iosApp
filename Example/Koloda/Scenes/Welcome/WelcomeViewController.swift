//
//  WelcomeViewController.swift
//  Koloda
//
//  Created by Alex Cuello ortiz on 13/05/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import Alamofire
import Firebase
import FirAu
class WelcomeViewController: UIViewController {

    
    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contractIDTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    var timer:Timer!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.loginButton.layer.cornerRadius = 8
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(WelcomeViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
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
