//
//  AskViewController.swift
//  Koloda
//
//  Created by Alex Cuello ortiz on 12/05/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import Firebase
import Alamofire
import CoreLocation

class AskViewController:UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, LabelTextFieldCellProtocol, CLLocationManagerDelegate {
    
    
    var labelTextFieldCellProtocol:LabelTextFieldCellProtocol?
    
    var incidencePictureURL: String!
    var incidenceDescription: String!
    
    var loaderIndicator:UIActivityIndicatorView!
    
    var locationManager:CLLocationManager?
    var currentLocation:CLLocation?
    
    @IBOutlet var askButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.askButton.layer.cornerRadius = 8
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.startUpdatingLocation()
        
        locationManager?.requestAlwaysAuthorization()
        
        self.loaderIndicator = UIActivityIndicatorView()
        view.addSubview(loaderIndicator)
        
        
        let centerX = NSLayoutConstraint(item: loaderIndicator, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 2)
        
        let centerY = NSLayoutConstraint(item: loaderIndicator, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([centerX, centerY])
        
        loaderIndicator.hidesWhenStopped = true
        loaderIndicator.stopAnimating()
        
    }
    
    @IBAction func askButtonPressed(_ sender: Any) {
        
        loaderIndicator.startAnimating()
        self.loaderIndicator.layer.zPosition = 1
        //POST /users/:userID/complains param: title, url imagen, lat, lon
        let user = FIRAuth.auth()?.currentUser!
        
        self.incidenceDescription = self.incidenceDescription.replacingOccurrences(of: " ", with: "%20")
        let response = Alamofire.request("\(Constants.ngrokURL)/users/\(user!.uid)/complains?title=\(self.incidenceDescription!)&image_url=\(self.incidencePictureURL!)&lat=\(self.currentLocation!.coordinate.latitude)&lon=\(self.currentLocation!.coordinate.longitude)", method: .post)
            .responseJSON(completionHandler: { (response) in
                print(response)
                if let json = response.result.value {
                    print("JSON: \(json)")
                    self.loaderIndicator.stopAnimating()
                    self.navigationController?.popViewController(animated: true)
                }
            })

        print(response)
        
    }
    
    func textFieldDidChangeValue(sender: UITextField) {
            self.incidenceDescription = sender.text!
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.incidenceDescription = textField.text!
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation = locations[0]
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
