//
//  NewOrderweb.swift
//  SmartFix
//
//  Created by mac on 7/29/18.
//  Copyright © 2018 tr. All rights reserved.
//

import UIKit
import WebKit
class NewOrderweb: UIViewController,WKNavigationDelegate{
    
    //MARK:- Outlet
    @IBOutlet weak var mywebview: WKWebView!
    
    
    @IBOutlet weak var refresh: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        BackgroundProcess()
        
        
        setupView()
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
  
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
         self.refresh.stopAnimating()
        // create the alert
        let alert = UIAlertController(title: "خطا", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "حسنا", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
    }
  
   
    

    
    func setupView()  {
        self.navigationItem.title="طلب صيانة"
        self.navigationItem.backBarButtonItem=UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor=UIColor.white
    }
    
    func BackgroundProcess()  {
        DispatchQueue.global(qos: .background).async {
            //background code
            DispatchQueue.main.async {
                
                self.loadWebView()
            }
        }
    }
    func loadWebView()
      {
        let url = URL(string:  "http://www.smartfixsa.com/maintenance/")
        mywebview.load(URLRequest(url: url!))
         mywebview.navigationDelegate = self
      
       }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    self.refresh.stopAnimating()
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
          self.refresh.startAnimating()
     
    }
}
