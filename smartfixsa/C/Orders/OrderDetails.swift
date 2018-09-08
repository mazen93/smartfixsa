//
//  OrderDetails.swift
//  SmartFix
//
//  Created by tr on 7/17/18.
//  Copyright © 2018 tr. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

import Realm
import RealmSwift
import CoreLocation


class OrderDetails: UIViewController,CLLocationManagerDelegate {

    //var userList:Results<CentersModel>!
    
    var userList:[CentersModel]=[]
    
    var CenterLocation: CLLocation?
    
    var locationss=[CLLocation]()
    
    var userCurrentLocation:CLLocation!
    var locationManager:CLLocationManager!
    
    let animation = 0.0
    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var stack2: UIStackView!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var Tbv: UITableView!
    @IBOutlet weak var Tbv2: UITableView!
    var ref:DatabaseReference?
   
    @IBOutlet weak var orderbuttonVIew: UIButton!
    @IBOutlet weak var raal: UILabel!
    @IBOutlet weak var monthsLB: UILabel!
    
    var CentersList = [OrderTypeModel]()
    var IssueList = [OrderPartsModel]()
    var databaseRefrence:DatabaseReference?
  
    
    var orderKey:OrderModel!
    var partskey:OrderTypeModel!
    
  
  
    @IBOutlet weak var priceLabelNot: UILabel!
    
    @IBOutlet weak var warrantyLabelNot: UILabel!
    
  
    //MARK:- Outlet
    @IBOutlet weak var gerantyLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
  
    @IBOutlet weak var orderButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
     
//
//
//        if let name = UserDefaults.standard.string(forKey: "ok") {
//            print("name is\(name)")
//
//        }else{
//            Alerts(title: "تحذير", message: "علما بان كل المنتجات المستخدمه ليست اصليه ")
//        }
        
        setupView()
                    Tbv.isHidden = true
                    Tbv2.isHidden = true
        
                    getDataType()
                    // print("ketyyyyyy= \(orderKey.id.value!)")
                    determineMyCurrentLocation()
        
        
        
        if let name = UserDefaults.standard.string(forKey: "ok") {
                        print("name is\(name)")
            
                    }else{
                        Alerts(title: "تحذير", message: "علما بان كل المنتجات المستخدمه ليست اصليه ")
                    }
        
        
        
    }
    
    
    
    func Alerts(title:String,message:String)  {
        // Create the alert controller
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
            
            
            
            UserDefaults.standard.set("ok", forKey: "ok")
            NSLog("OK Pressed")
        }
       
        
        // Add the actions
        alertController.addAction(okAction)
      
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    
 
    
    @IBAction func onclickbutton(_ sender: Any) {
        if Tbv.isHidden {
            animate(toogle: true)
        } else {
            animate(toogle: false)
        }
        
        UIView.animate(withDuration: animation) {
            
            self.stack2.alpha = 0
            
            
        }
    }
    func animate(toogle:Bool) {
        if toogle {
            UIView.animate(withDuration: 0.3) {
                self.Tbv.isHidden = false
            }
            
        } else {
            UIView.animate(withDuration: 0.3) {
                self.Tbv.isHidden = true
            }
            
        }
    }
    
    @IBAction func onclickbutton2(_ sender: Any) {
        if Tbv2.isHidden {
            pubic(toogle: true)
        } else {
            pubic(toogle: false)
        }
        
        
    }
    func pubic(toogle:Bool) {
        if toogle {
            UIView.animate(withDuration: 0.3) {
                self.Tbv2.isHidden = false
            }
            
            
        } else {
            UIView.animate(withDuration: 0.3) {
                self.Tbv2.isHidden = true
            }
            
        }
    }
    
    

    func getDataType() {
        
        ref=Database.database().reference().child("service_pricing_i").child("models")
        let query=ref?.queryOrdered(byChild: "parent_id").queryEqual(toValue: orderKey.id)
        query?.observe(.value) { (snapshot) in
            
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                
                
                
                //iterating through all the values
                for artists in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    
                    let artistObject = artists.value as? [String: AnyObject]
                    
                    let Name  = artistObject?["name"] as! String
                    let id = artistObject?["id"] as! String
                    
                    // create Ream Object
                    let user=OrderTypeModel(name: Name, id: id)
                    
                    self.CentersList.append(user)
                }
                self.Tbv.reloadData()
                
                
                
            }
        }
        
    }
 
        
        

    
    // get data from firebase database
    func getDataissue(partkey:OrderTypeModel) {
        
        self.IssueList.removeAll()
        
        
        btn2.setTitle("النوع", for: .normal)
        
      
    databaseRefrence=Database.database().reference().child("service_pricing_i").child("parts")
        databaseRefrence?.keepSynced(true)
       
        //  print(" id == \( CentersList.id)")
        //   databaseRefrence.queryOrderedByKey("phoneid").queryEqual(toValue: CentersList.id)
        
        let query=databaseRefrence?.queryOrdered(byChild: "parent_model_id").queryEqual(toValue:partskey.id)
        query?.observe(.value) { (snapshot) in
            
            
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                
                
                
                //iterating through all the values
                for snap in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                 //   print(snap)
                    let artistObject = snap.value as? [String: AnyObject]
                    
                   
                     let Name  = artistObject?["name"] as! String
                    //let id = artistObject?["id"] as! Int
                    
                    let price=artistObject?["price"] as! Int
                    let warrenty=artistObject?["warranty"] as! Int
                    // create Ream Object
                    
                    let user=OrderPartsModel(name: Name, warrenty: warrenty, price: price)
                    
                    self.IssueList.append(user)
                }
                self.Tbv2.reloadData()
                
                
                
            }
            
        }
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func setupView()  {
        self.navigationItem.title="طلب صيانة"
        self.navigationItem.backBarButtonItem=UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor=UIColor.white
    }
        
    
    
   
   
    

    
    
    
        
    
    
    @IBAction func orderButtonClick(_ sender: Any) {
        
      
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "orderCenterOrder") as? orderCenterOrder
            vc?.CenterLocation=CenterLocation
       
        self.navigationController?.pushViewController(vc!, animated: true)
    }
   











    
    //loc
    
    func determineMyCurrentLocation() {
        
        
        
        
        
        print("determine")
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        userCurrentLocation=userLocation
        
        
        
        
        
        
        
        
        getData2()
        
    }
    
    // location
    
    func locationInLocations(locations: [CLLocation], closestToLocation location: CLLocation) -> CLLocation? {
        if locations.count == 0 {
            return nil
        }
        
        var closestLocation: CLLocation?
        var smallestDistance: CLLocationDistance?
        
        for locationn in locations {
            let distance = location.distance(from: locationn)
            if smallestDistance == nil || distance < smallestDistance! {
                closestLocation = locationn
                smallestDistance = distance
            }
        }
        

        
        print("closestLocation: \(closestLocation!), distance: \(smallestDistance!)")
       
        CenterLocation=closestLocation!
        
        
        getCenterData(loca: CenterLocation!)
        
        
        
        return closestLocation
    }
    
    
    
    
    func getlocation(userLocation:CLLocation)  {
        
        
        
        
        let userL=CLLocation(latitude: userCurrentLocation.coordinate.latitude, longitude:  userCurrentLocation.coordinate.longitude)
        
      
        
        
        
        locationInLocations(locations: locationss, closestToLocation: userL)
        
    }
    
    
    
    func getData2() {
        
        
        
        
        print("get data 2")
        ref = Database.database().reference().child("service_centers")
        
        //observing the data changes
        ref?.observe(DataEventType.value, with: { (snapshot) in
            
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                
                
                
                //iterating through all the values
                for artists in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    
                    
                    
                    
                    let artistObject = artists.value  as? [String: AnyObject]
                    
                    
                    
                    
                    
                    let lat  = artistObject?["lat"] as! Double
                    let lng  = artistObject?["lng"] as! Double
                    
                    let _=LatLngModel(lat:lat, lng: lng)
                    
                    self.locationss.append(CLLocation(latitude: lat, longitude: lng))
                    
                 
                }
              
                self.getlocation(userLocation:self.userCurrentLocation)
                
                
            }
            
        })
    }

    
    
    ///get Center data
    
    
    
    func getCenterData(loca:CLLocation) {
        
        let lat=loca.coordinate.latitude
        let lng=loca.coordinate.longitude
     
        
        
        
        
        
        
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
                    
                    let laLng=artistObject!["latLng"] as! [String:Any]
                    let lat  = laLng["lat"] as! Double
                    let lng  = laLng["lng"] as! Double
                    
                        // create Ream Object
     let user=CentersModel(name: CenterName, addres: CenterAddress, service: CenterService, photo: CenterImage, lat: lat, lng: lng)
                        
                       self.userList.append(user)
                        
                        //appending it to list
                        self.reloadData()
                        
                    }
                    
                    
                    
                }
                
            })
        }
        
        
        
        func reloadData()  {
        //    userList=Realm.objects(CentersModel.self)
        
        }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }


   

}

extension OrderDetails:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == Tbv {
            return CentersList.count
        } else{
            return IssueList.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if tableView == Tbv {
            cell.textLabel?.text = CentersList[indexPath.row].name
            return cell
        } else {
            cell.textLabel?.text = IssueList[indexPath.row].name
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == Tbv {
            btn.setTitle("\(CentersList[indexPath.row].name)", for: .normal)
            partskey=CentersList[indexPath.row]
            print(CentersList[indexPath.row].name)
              print(CentersList[indexPath.row].id)
            
            getDataissue(partkey: CentersList[indexPath.row])
          
            animate(toogle: false)
            UIView.animate(withDuration: animation) {
                
                self.stack2.alpha = 1
                
                
            }
        } else {
            btn2.setTitle("\(IssueList[indexPath.row].name)", for: .normal)
            
            
            monthsLB.alpha=1
            raal.alpha=1
            gerantyLabel.alpha=1
            priceLabel.alpha=1
            priceLabelNot.alpha=1
            warrantyLabelNot.alpha=1
            
            
            gerantyLabel.text=String(IssueList[indexPath.row].warrenty)
            priceLabel.text=String(IssueList[indexPath.row].price)
            orderbuttonVIew.alpha=1
            
            
            pubic(toogle: false)
            
        }
    }
   
    
    
    
    
}
