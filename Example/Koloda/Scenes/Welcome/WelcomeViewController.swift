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
import FirebaseAuth

class WelcomeViewController: UIViewController {

    
    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contractIDTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var logoVieww: UIView!
    
    var timer:Timer!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.welcomeLabel.isHidden = true
        self.titleLabel.isHidden = true
        self.contractIDTextField.isHidden = true
        self.loginButton.isHidden = true
        self.logoVieww.isHidden = true
        
        try! FIRAuth.auth()!.signOut()
        
        FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
            if let _ = user {
                self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
                self.performSegue(withIdentifier: "loginSegue", sender: self)
            }
            else {
                self.welcomeLabel.isHidden = false
                self.titleLabel.isHidden = false
                self.contractIDTextField.isHidden = false
                self.loginButton.isHidden = false
                self.logoVieww.isHidden = false
                
            }
        })
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.loginButton.layer.cornerRadius = 8
        self.appearView(withView: self.logoVieww)
        self.appearView(withView: self.titleLabel)
        self.appearView(withView: self.contractIDTextField)
        self.appearView(withView: self.loginButton)
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(WelcomeViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // create a corresponding local notification
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func appearView(withView customView: UIView) {
        
        customView.alpha = 0

        
        UIView.animate(withDuration: 2, animations: {
            customView.alpha = 1
        }, completion: {
            finished in
            
        })

    }
    
    
    func hiddeView(withView customView: UIView) {
        
        customView.alpha = 1
        
        UIView.animate(withDuration: 1.2, animations: {
            customView.alpha = 0
        }, completion: {
            finished in
            customView.isHidden = true
        })
            }

    @IBAction func loginButtonPressed(_ sender: Any) {
        FIRAuth.auth()?.createUser(withEmail: self.contractIDTextField.text!, password: "test1234", completion: { (user, error) in
            if let error = error {
                print(error)
                let refreshAlert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { (action: UIAlertAction!) in
                }))
                
                refreshAlert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action: UIAlertAction!) in
                }))
                
                self.present(refreshAlert, animated: true, completion: nil)
            }
        })
    }
}
