//
//  ViewController.swift
//  SmartFix
//
//  Created by tr on 7/17/18.
//  Copyright © 2018 tr. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift
class StoreVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    //list to store all the artist
   // var StoreList = [StoreModel]()
    
//    var StoreList = [StoreModel(id: "1", title: "هاند فري ", company: "سامسونج", price: "٢٥٠ ريال"),StoreModel(id: "1", title: "هاند في ", company: "سامسونج", price: "٢٥٠ ريال")]
    
    
    //  var StoreList:Results<StoreModel>!
    
    
    
    var StoreList:[StoreModel]=[]

    @IBOutlet weak var updateLabel: UILabel!
    
    
    
    @IBOutlet weak var collection: UICollectionView!
    
    
       var ref: DatabaseReference!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
    
      
        setCollectionView()
        
        //reloading the tableview
      //  self.collection.reloadData()
        
        
        setupView()
        BackgroundProcess()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    
    func BackgroundProcess() {
        DispatchQueue.global(qos: .background).async {
            //background code
            DispatchQueue.main.async {
               // self.activityIndicatorCall()
                self.getData()
            }
        }
    }
    func setupView()  {
        self.navigationItem.title="المتجر"
        self.navigationItem.backBarButtonItem=UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor=UIColor.white
    }
    func setCollectionView(){
        collection.dataSource = self
        collection.delegate = self
    }
    
    
    
    
    
    private func getData(){
        
        ref = Database.database().reference().child("market");
        
        //observing the data changes
        ref.observe(DataEventType.value, with: { (snapshot) in
            
            //if the reference have some values
            if snapshot.childrenCount > 0 {
               
                
                //iterating through all the values
                for artists in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    
                    let artistObject = artists.value as? [String: AnyObject]
                    
                    let title  = artistObject?["item_name"] as! String
                    let price = artistObject?["price"] as! Int
                    let pic  = artistObject?["image_url"] as! String
                
                    
                    // create Ream Object
                    let user=StoreModel( title: title, picture: pic,price:price)
                    
                
                    self.StoreList.append(user)
                    
                    //appending it to list
                    self.reloadData()
                }
                
                //reloading the tableview
              //  self.collection.reloadData()
            }
        })
        
    }
    
    func reloadData()  {
       // StoreList=uiRealm.objects(StoreModel.self)
        self.collection.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        
        
        
       
            return StoreList.count
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Storecell", for: indexPath) as! StoreCell
        
        cell.set(store: StoreList[indexPath.row] )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updateLabel.alpha=1
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.updateLabel.alpha = 0
        }
    }
    


}

