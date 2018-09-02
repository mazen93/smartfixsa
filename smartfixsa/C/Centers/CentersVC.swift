//
//  firstpage.swift
//  SmartFix
//
//  Created by tr on 7/17/18.
//  Copyright © 2018 tr. All rights reserved.
//

import UIKit
import Firebase
import Realm
import RealmSwift
import CoreLocation

class CentersVC: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    

    
    var activityIndicator:UIActivityIndicatorView=UIActivityIndicatorView()
    
   // var userList:Results<CentersModel>!
     var userList:[CentersModel]=[]
    @IBOutlet weak var tableV1: UITableView!
    
    //var locations:CLLocation
    var ref: DatabaseReference!
    
   var limitOfLoad=10
    let totalEntries=100
    var loc=[CLLocation]()
    
    var getLatLng=[LatLngModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
      
        BackgroundProcess()
        setupTableView()
    }
    
//
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    

    
    
    func activityIndicatorCall()  {
        activityIndicator.center=self.view.center
        activityIndicator.hidesWhenStopped=true
        activityIndicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
    }
    func setupTableView()  {
    
     // self.navigationController?.hidesBarsOnSwipe=true
        self.navigationItem.title="المراكز المعتمده للصيانه"
        self.navigationItem.backBarButtonItem=UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor=UIColor.white
       
        tableV1.delegate = self
        tableV1.dataSource = self
        tableV1.tableFooterView=UIView(frame: .zero)
    }
    
    func BackgroundProcess() {
        DispatchQueue.global(qos: .background).async {
            //background code
            DispatchQueue.main.async {
                self.activityIndicatorCall()
                self.getData()
                
            }
        }
    }
    
    func getData() {
        
        ref = Database.database().reference().child("service_centers")
         Database.database()
        
        //observing the data changes
        ref.observe(DataEventType.value, with: { (snapshot) in
            self.activityIndicator.stopAnimating()
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                
                
                
                //iterating through all the values
                for artists in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    
                    
                    
                    
                    let artistObject = artists.value  as? [String: AnyObject]
                    // as? [String: AnyObject]
                    
                    //Dictionary<String, AnyObject>
                    
                    let CenterName  = artistObject?["name"] as! String
                    let CenterAddress = artistObject?["address"] as! String
                    let CenterService  = artistObject?["the_service"] as! String
                    let CenterImage  = artistObject?["image"] as! String
                    
                    
                    let laLng=artistObject!["latLng"] as! [String:Any]
                    let lat  = laLng["lat"] as! Double
                     let lng  = laLng["lng"] as! Double
                    
              
                    
                    
                    print("lat is \(lat)")
                   
                    
                    
                    
                    //                    //creating artist object with model and fetched values
                    //                    let artist = CentersModel(name: CenterName, addres: CenterAddress, service: CenterService)
                    //                    //appending it to list
                    //                    self.CentersList.append(artist)
                    //                }
                    //
                    //                //reloading the tableview
                    //                self.tableV1.reloadData()
                    //            }
                    //        })
                    //
                    //
                    //
                    //
                    //
                    //    }
                    
                    
                    
                    // create Ream Object
                    let user=CentersModel(name: CenterName, addres: CenterAddress, service: CenterService, photo: CenterImage, lat: lat, lng: lng)
                    
//                    user.name=CenterName
//                    user.addres=CenterAddress
//                    user.service=CenterService
//                    user.lat.value=lat
//                    user.lng.value=lng
//                    user.photo=CenterImage
//                    user.writeToRealm()
                    
                    //appending it to list
                    
                     self.userList.append(user)
                    self.reloadData()
                    
                }
                
                
                
            }
            
        })
    }
    
    
    
    func reloadData()  {
        
        
     //   userList=Realm.objects(CentersModel.self)
        //userList=Realm.objects()
        self.tableV1.reloadData()
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return CentersList.count
        
      
            return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Centercell
        cell.set(center: userList[indexPath.row] )
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "Go") as? centerinfo
        vc?.CentersList=userList[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
   
    
    
    
    
    
    
    
    
    
    
    
    
}

