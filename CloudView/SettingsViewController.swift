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
    
    @IBOutlet weak var minTempOne: UISlider!
    @IBOutlet weak var maxTempOne: UISlider!
    @IBOutlet weak var minTempTwo: UISlider!
    @IBOutlet weak var maxTempTwo: UISlider!
    @IBOutlet weak var minTempThree: UISlider!
    @IBOutlet weak var maxTempThree: UISlider!
    
    @IBOutlet weak var minTempOneLbl: UILabel!
    @IBOutlet weak var maxTempOneLbl: UILabel!
    @IBOutlet weak var minTempTwoLbl: UILabel!
    @IBOutlet weak var maxTempTwoLbl: UILabel!
    @IBOutlet weak var minTempThreeLbl: UILabel!
    @IBOutlet weak var maxTempThreeLbl: UILabel!
    
    
    @IBAction func minTempOneChanged() {
        mainSettingsData.minTempOne = Int(minTempOne.value)
        minTempOneLbl.text = "\(mainSettingsData.minTempOne)"
    }
    
    @IBAction func maxTempOneChanged() {
        mainSettingsData.maxTempOne = Int(maxTempOne.value)
        maxTempOneLbl.text = "\(mainSettingsData.maxTempOne)"
        
    }
    
    @IBAction func minTempTwoChanged() {
        mainSettingsData.minTempTwo = Int(minTempTwo.value)
        minTempTwoLbl.text = "\(mainSettingsData.minTempTwo)"
    }
    
    @IBAction func maxTempTwoChanged() {
        mainSettingsData.maxTempTwo = Int(maxTempTwo.value)
        maxTempTwoLbl.text = "\(mainSettingsData.maxTempTwo)"
    }
    
    @IBAction func minTempThreeChanged() {
        mainSettingsData.minTempThree = Int(minTempThree.value)
        minTempThreeLbl.text = "\(mainSettingsData.minTempThree)"
    }
    
    @IBAction func maxTempThreeChanged() {
        mainSettingsData.maxTempThree = Int(maxTempThree.value)
        maxTempThreeLbl.text = "\(mainSettingsData.maxTempThree)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        minTempOne.value = Float(mainSettingsData.minTempOne)
        maxTempOne.value = Float(mainSettingsData.maxTempOne)
        
        minTempTwo.value = Float(mainSettingsData.minTempTwo)
        maxTempTwo.value = Float(mainSettingsData.maxTempTwo)
        
        minTempThree.value = Float(mainSettingsData.minTempThree)
        maxTempThree.value = Float(mainSettingsData.maxTempThree)
        
        minTempOneLbl.text = "\(mainSettingsData.minTempOne)"
        maxTempOneLbl.text = "\(mainSettingsData.maxTempOne)"
        
        minTempTwoLbl.text = "\(mainSettingsData.minTempTwo)"
        maxTempTwoLbl.text = "\(mainSettingsData.maxTempTwo)"
        
        minTempThreeLbl.text = "\(mainSettingsData.minTempThree)"
        maxTempThreeLbl.text = "\(mainSettingsData.maxTempThree)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

