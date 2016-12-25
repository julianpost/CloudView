//
//  TempViewController.swift
//  NOAA
//
//  Created by Julian Post on 7/24/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import UIKit

class TempViewController: UIViewController {
    
    @IBOutlet weak var tempViewOne: UIView!
    
    @IBOutlet weak var minTempOne: UISlider!
    @IBOutlet weak var maxTempOne: UISlider!
    
    
    @IBOutlet weak var minTempOneLbl: UILabel!
    @IBOutlet weak var maxTempOneLbl: UILabel!
    
    
    @IBAction func minTempOneChanged() {
        mainSettingsData.minTempOne = Int(minTempOne.value)
        minTempOneLbl.text = "\(mainSettingsData.minTempOne)"
    }
    
    @IBAction func maxTempOneChanged() {
        mainSettingsData.maxTempOne = Int(maxTempOne.value)
        maxTempOneLbl.text = "\(mainSettingsData.maxTempOne)"
        
    }
    
    @IBAction func dismissView(_ sender: AnyObject) {
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIManager.sharedInstance.fetchTemp() { result in
            UpdateView.handleTempCompletion(self.tempViewOne, temp: result)
        }
        
        minTempOne.value = Float(mainSettingsData.minTempOne)
        maxTempOne.value = Float(mainSettingsData.maxTempOne)
        
        minTempOneLbl.text = "\(mainSettingsData.minTempOne)"
        maxTempOneLbl.text = "\(mainSettingsData.maxTempOne)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}

