//
//  SettingsViewController.swift
//  NOAA
//
//  Created by Julian Post on 10/16/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import Foundation
import UIKit


class SettingsViewController: UIViewController/*, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate*/ {
    
    @IBOutlet weak var tblResults: UITableView!
    
    @IBOutlet weak var zipField: UITextField!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

