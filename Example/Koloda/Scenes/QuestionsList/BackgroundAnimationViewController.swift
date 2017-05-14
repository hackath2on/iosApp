//
//  BackgroundAnimationViewController.swift
//  Koloda
//
//  Created by Eugene Andreyev on 7/11/15.
//  Copyright (c) 2015 CocoaPods. All rights reserved.
//

import UIKit
import Koloda
import pop
import Firebase
import Alamofire
import Kingfisher
import SwiftyJSON
import CoreLocation



private let frameAnimationSpringBounciness: CGFloat = 9
private let frameAnimationSpringSpeed: CGFloat = 16
private let kolodaCountOfVisibleCards = 2
private let kolodaAlphaValueSemiTransparent: CGFloat = 0.1

class BackgroundAnimationViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var customView: UIView!
    var numberOfCards: Int = 0
    var complains:[Complain] = []
    
    struct Complain {
        var id:String!
        var picture:String!
        var description:String!
    }
    
    var locationManager:CLLocationManager?
    var currentLocation:CLLocation?
    
    @IBOutlet weak var kolodaView: CustomKolodaView!
    
    override func viewWillDisappear(_ animated: Bool) {
        self.title = " "
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Incidencias"
        self.getComplains()
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        kolodaView.alphaValueSemiTransparent = kolodaAlphaValueSemiTransparent
        kolodaView.countOfVisibleCards = kolodaCountOfVisibleCards
        kolodaView.delegate = self
        kolodaView.dataSource = self
        kolodaView.animator = BackgroundKolodaAnimator(koloda: kolodaView)
        
        self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.startUpdatingLocation()
        
        locationManager?.requestAlwaysAuthorization()
    }
    
    
    //MARK: IBActions
    @IBAction func leftButtonTapped() {
//        POST /users/:userID/complains/:complainID/answer params: answer, lat lon
        let user = FIRAuth.auth()?.currentUser!
        Alamofire.request("\(Constants.ngrokURL)/users/\(user!.uid)?answers=\(false)&lat=\(self.currentLocation!.coordinate.latitude)&lon=\(self.currentLocation!.coordinate.longitude)", method: .post).responseJSON { (response) in
            
            print(response)
        }
        kolodaView?.swipe(.left)
    }
    
    @IBAction func rightButtonTapped() {
//        POST /users/:userID/complains/:complainID/answer params: answer, lat lon
        let user = FIRAuth.auth()?.currentUser!
        print(self.complains[kolodaView.currentCardIndex].description)
        Alamofire.request("\(Constants.ngrokURL)/users/\(user!.uid)/complains/\(self.complains[kolodaView.currentCardIndex].id!)/answers?answer=\(true)&lat=\(self.currentLocation!.coordinate.latitude)&lon=\(self.currentLocation!.coordinate.longitude)", method: .post).responseJSON { (response) in print(response)}
        kolodaView?.swipe(.right)
    }
    
    @IBAction func undoButtonTapped() {
        kolodaView?.revertAction()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation = locations[0]
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

//MARK: KolodaViewDelegate
extension BackgroundAnimationViewController: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        kolodaView.resetCurrentCardIndex()
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
//        UIApplication.shared.openURL(URL(string: "https://yalantis.com/")!)
    }
    
    func kolodaShouldApplyAppearAnimation(_ koloda: KolodaView) -> Bool {
        return true
    }
    
    func kolodaShouldMoveBackgroundCard(_ koloda: KolodaView) -> Bool {
        return false
    }
    
    func kolodaShouldTransparentizeNextCard(_ koloda: KolodaView) -> Bool {
        return true
    }
    
    func koloda(kolodaBackgroundCardAnimation koloda: KolodaView) -> POPPropertyAnimation? {
        let animation = POPSpringAnimation(propertyNamed: kPOPViewFrame)
        animation?.springBounciness = frameAnimationSpringBounciness
        animation?.springSpeed = frameAnimationSpringSpeed
        return animation
    }
}

// MARK: KolodaViewDataSource
extension BackgroundAnimationViewController: KolodaViewDataSource {
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return self.complains.count
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        
        let imageView = UIImageView(image: UIImage(named: "QuejaImagenEjemplo"))
        
        if self.complains[index].picture == "" {
        
            let url = URL(string: "http://www.lavanguardia.com/r/GODO/LV/p3/WebSite/2016/05/19/Recortada/img_cvillalonga_20160219-115503_imagenes_lv_getty_agua_grifo_22222222222-664-ko2E--992x558@LaVanguardia-Web.jpg")
            imageView.kf.setImage(with: url)
        }
        else {
            let url = URL(string: self.complains[index].picture)
            imageView.kf.setImage(with: url)
        }
        
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        
        
        let newView = UIView()
        newView.backgroundColor = UIColor.black
        newView.alpha = 0.75
        newView.layer.cornerRadius = 8
        newView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addSubview(newView)
        
        let newLabel = UILabel()
        newLabel.textColor = UIColor.white
        newLabel.font = newLabel.font.withSize(22)
        newLabel.text = self.complains[index].description
        newLabel.numberOfLines = 10
        newLabel.layer.zPosition = 1
        newLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.addSubview(newLabel)
        
        let horizontalConstraint = NSLayoutConstraint(item: newView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: imageView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        
        let verticalConstraint = NSLayoutConstraint(item: newView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: imageView, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        
        let verticalConstraint2 = NSLayoutConstraint(item: newView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: imageView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        
        let heightConstraint = NSLayoutConstraint(item: newView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 100)
        
        
        
        let horizontalConstraint3 = NSLayoutConstraint(item: newLabel, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: imageView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 8)
        
        let verticalConstraint3 = NSLayoutConstraint(item: newLabel, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: imageView, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 2)
        
        let verticalConstraint4 = NSLayoutConstraint(item: newLabel, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: imageView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        
        
        let heightConstraint3 = NSLayoutConstraint(item: newLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 100)
        
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, verticalConstraint2, heightConstraint, horizontalConstraint3, verticalConstraint3, verticalConstraint4, heightConstraint3])
        
        return imageView
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("CustomOverlayView", owner: self, options: nil)?[0] as? OverlayView
    }
}
