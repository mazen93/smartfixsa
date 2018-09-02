//
//  ReguestOrder.swift
//  SmartFix
//
//  Created by tr on 7/17/18.
//  Copyright © 2018 tr. All rights reserved.
//

import UIKit
import RealmSwift
import Realm
import Firebase
import SafariServices
class ReguestOrder: UIViewController ,UITableViewDelegate,UITableViewDataSource {

    var ref: DatabaseReference!
   // var OrderList:Results<OrderModel>!
    var OrderList:[OrderModel]=[]
@IBOutlet weak var tableV1: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableV1.separatorColor=UIColor(white: 0.95, alpha: 1)
       setCollectionView()
       BackgroundProcess()
}
    func setCollectionView(){
        tableV1.tableFooterView=UIView(frame: .zero)
        tableV1.delegate = self
        tableV1.dataSource = self
        self.navigationItem.title="طلب صيانة"
        self.navigationItem.backBarButtonItem=UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor=UIColor.white
    }
    
    
    func BackgroundProcess() {
        DispatchQueue.global(qos: .background).async {
            //background code
            DispatchQueue.main.async {
                self.getDatabase()
               // self.getnewData()
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }

    
    // get data from firebase database
    func getDatabase() {
        
        ref=Database.database().reference().child("service_pricing_i").child("brands")
        ref.observe(.value) { (snapshot) in
            
            
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                
                
                
                //iterating through all the values
                for snap in snapshot.children.allObjects as! [DataSnapshot] {
                    
                    let artistObject = snap.value as? [String: AnyObject]
                    
                    let Name  = artistObject?["name"] as! String
                    let id = artistObject?["key"] as! String
                    
                    
                    
                    // create Ream Object
                    let user=OrderModel(phone: Name, id: id)
                   
                    
                    self.OrderList.append(user)
                    
                    //appending it to list
                    self.reloadData()
                    
                }
                
                
                
            }
            
        }
        
        
        
    }
    func reloadData()  {
       // OrderList=RLMRealm.objects(OrderModel.self)
        self.tableV1.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
   
//
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collectioV1.dequeueReusableCell(withReuseIdentifier: "CELL", for: indexPath) as! orderCelll
//
//
//        cell.set(center: OrderList[indexPath.row] )
//
//
//
//
//    return cell
//
//
//
//
//}

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       // let vc = storyboard?.instantiateViewController(withIdentifier: "OrderDetails") as? OrderDetails
        if OrderList[indexPath.row].phone == "iPhone"{
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "OrderDetails") as? OrderDetails
        vc?.orderKey=OrderList[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            
                    let vc=SFSafariViewController(url: URL(string: "http://www.smartfixsa.com/maintenance/")!)
                    self.present(vc, animated: true, completion: nil)
        }
    }
    
   

    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if OrderList != nil{
            return OrderList.count
        }else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell") as! orderCell
        
        cell.contentView.backgroundColor=UIColor(white: 0.95, alpha: 1)
        cell.set(center: OrderList[indexPath.row] )
       
    
        
       return cell
        
        
        
        
      
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // let vc = storyboard?.instantiateViewController(withIdentifier: "OrderDetails") as? OrderDetails
        if OrderList[indexPath.row].phone == "Apple"{
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "OrderDetails") as? OrderDetails
            vc?.orderKey=OrderList[indexPath.row]
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "NewOrderweb") as? NewOrderweb
           
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    
    
    
    
    
    
}
