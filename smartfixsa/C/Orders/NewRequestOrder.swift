//
//  NewRequestOrder.swift
//  SmartFix
//
//  Created by mac on 8/22/18.
//  Copyright © 2018 tr. All rights reserved.
//

import UIKit
import RealmSwift
import Realm
import Firebase
import SafariServices


class NewRequestOrder: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    var ref: DatabaseReference!
  //  var OrderList:Results<OrderModel>!
    
     var OrderList:[OrderModel]=[]
    
    
    
    var name = ["k","k","k","k",]
    
    @IBOutlet weak var collection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collection.dataSource = self
        collection.delegate = self
        BackgroundProcess()
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
                    user.phone=Name
                    user.id=id
                    self.OrderList.append(user)
                    
                  //  user.writeToRealm()
                    
                    //appending it to list
                    self.reloadData()
                    
                }
                
                
                
            }
            
        }
        
        
        
    }
    func reloadData()  {
      //  OrderList=Realm.objects(OrderModel.self)
        self.collection.reloadData()
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if OrderList != nil{
            return OrderList.count
        }else{
            return 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "smartCollectionViewCell", for: indexPath) as! smartCollectionViewCell
        
        
        cell.label.text=OrderList[indexPath.row].phone
        
        let imgName = "ic_\(String(describing: OrderList[indexPath.row].phone))"
        print("img name\(imgName)")
        cell.image.image=UIImage(named: String(imgName))
        
        
        
        
        
        
        return cell
        
        
        
     
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
   
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if OrderList[indexPath.row].phone == "Apple"{
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "OrderDetails") as? OrderDetails
            vc?.orderKey=OrderList[indexPath.row]
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "NewOrderweb") as? NewOrderweb
            
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //number of cells we want to show for each row
        let numOfCells : CGFloat = 2.0
        
        //Calculating the all white spaces between cells
        let paddingSpace : CGFloat = 5.0 * (numOfCells + 1)
        
        //Calculating the remaining width after ignoring the white spaces
        let availableWidth : CGFloat = self.view.layer.frame.width - paddingSpace
        
        //Each cell will have equal width
        let widthPerItem = availableWidth / numOfCells
        
        //The width and the height of the cell
        return CGSize(width: widthPerItem, height: widthPerItem)
        
        
        
    }
    
    
    
    
}
