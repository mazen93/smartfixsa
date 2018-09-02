//
//  orderCenterOrder.swift
//  SmartFix
//
//  Created by tr on 7/19/18.
//  Copyright © 2018 tr. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Firebase
import Kingfisher
class orderCenterOrder: UIViewController {
    
    
   
    
    // user current location
    var CenterLocation:CLLocation!
    var lat:Double=0
    var long:Double=0
   
    
    
    
    
    
   
    @IBOutlet weak var ServiceLabel: UILabel!
    @IBOutlet weak var AddressLabel: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var GoButton: UIButton!
    
    
    // MARK:- Var to get data from prev page
    var CentersList : CentersModel!
    
    // Var to get data from prev page
    var name : String = ""
  
    //var locations:CLLocation
    var ref: DatabaseReference!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        
      
        
 
    BackgroundProcess()
        
        setUpView()
       // setData()
        
        
        print("loc\(CenterLocation.coordinate.latitude)")
        getCenterData(loca: self.CenterLocation!)
    
    
    }
    
    
    func BackgroundProcess() {
        DispatchQueue.global(qos: .background).async {
            //background code
            DispatchQueue.main.async {
             //   self.determineMyCurrentLocation()
               
              //  self.getData2()
               // self.getCenterData(loca: self.CenterLocation!)
                
            }
        }
    }
   
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    
    
    @IBAction func GoButtonAction(_ sender: Any) {
        
        lunchToMap()
    }
    
    
    func lunchToMap() {
        let lat:CLLocationDegrees=self.lat
        let long:CLLocationDegrees=self.long
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
        GoButton.layer.borderWidth = 2
        GoButton.layer.borderColor = UIColor.white.cgColor
        
        self.navigationItem.backBarButtonItem=UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor=UIColor.white
       

    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.backBarButtonItem=UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor=UIColor.white
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
   

    

    
    ///get Center data
    
    
    
    func getCenterData(loca:CLLocation) {
        
        let lat=loca.coordinate.latitude
        let lng=loca.coordinate.longitude
        print(lat)
        print(lng)
        ref = Database.database().reference().child("service_centers")
        let querey=ref?.queryOrdered(byChild: "lat").queryEqual(toValue:lat).ref.queryOrdered(byChild: "lng").queryEqual(toValue:lng)
        
        querey?.observe(DataEventType.value, with: { (snapshot) in
            
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                
                
                for artists in snapshot.children.allObjects as! [DataSnapshot] {
                    let artistObject = artists.value  as? [String: AnyObject]
                    
                    
                    let CenterName  = artistObject?["name"] as! String
                    let CenterAddress = artistObject?["address"] as! String
                    let CenterService  = artistObject?["the_service"] as! String
                    let CenterImage  = artistObject?["image"] as! String
                    let lat  = artistObject?["lat"] as! Double
                    let lng  = artistObject?["lng"] as! Double
                    
//                    // create Ream Object
//                    let user=CentersModel()
//                    
//                    user.name=CenterName
//                    user.addres=CenterAddress
//                    user.service=CenterService
//                    user.lat.value=lat
//                    user.lng.value=lng
//                    
                    
                    self.ServiceLabel.text = CenterService
                    self.AddressLabel.text = CenterAddress
                    self.navigationItem.title=CenterName
                    let url = URL(string: CenterImage)
                    
                    
                 
                    
                    
                  self.photo.kf.setImage(with: url)
                    
                    self.lat=lat
                    self.long=lng
                    
                    
                    
                }
                
                
                
            }
            
        })
    }
    
    
    
  

}
