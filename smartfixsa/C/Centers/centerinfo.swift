//
//  centerinfo.swift
//  SmartFix
//
//  Created by tr on 7/17/18.
//  Copyright © 2018 tr. All rights reserved.
//

import UIKit
import MapKit
class centerinfo: UIViewController {
    

    
    
    @IBOutlet weak var GoButton: UIButton!
    @IBOutlet weak var ServiceLabel: UILabel!
    @IBOutlet weak var AddressLabel: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    var CentersList : CentersModel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
        
        setUpView()
        setData()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    
    
    @IBAction func GoButtonAction(_ sender: Any) {
        
        lunchToMap()
    }
    
    
    func lunchToMap() {
        let lat:CLLocationDegrees=CentersList.lat
        let long:CLLocationDegrees=CentersList.lng
        
        let regionDistance:CLLocationDistance=1000
        let coordinates=CLLocationCoordinate2DMake(lat, long)
        let regionSpan=MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Me"
        mapItem.openInMaps(launchOptions: options)
    }
    func setUpView(){
        
        // GoButton.layer.cornerRadius =  GoButton.frame.size.width/2
        GoButton.layer.cornerRadius = 10
        GoButton.layer.borderWidth = 1
        GoButton.layer.borderColor = UIColor.darkGray.cgColor
        
         self.navigationItem.title=CentersList.name
         self.navigationItem.backBarButtonItem=UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
         self.navigationController?.navigationBar.tintColor=UIColor.white
        
    }
    func setData() {
        
        ServiceLabel.text = CentersList.service
        AddressLabel.text = CentersList.addres
        
        
        
        print("image url \(CentersList.photo)")
        let url = URL(string: CentersList.photo)
        photo.kf.setImage(with: url)
    }

  

}
