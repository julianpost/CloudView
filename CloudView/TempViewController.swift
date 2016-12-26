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
    
    @IBOutlet var slider2:UIXRangeSlider!
    
   /* @IBAction func minTempOneChanged() {
        mainSettingsData.minTempOne = Int(minTempOne.value)
        minTempOneLbl.text = "\(mainSettingsData.minTempOne)"
    }
    
    @IBAction func maxTempOneChanged() {
        mainSettingsData.maxTempOne = Int(maxTempOne.value)
        maxTempOneLbl.text = "\(mainSettingsData.maxTempOne)"
        
    }*/
    
    @IBAction func sliderChanged() {
        
        mainSettingsData.minTempOne = Int(slider2.leftValue)
        mainSettingsData.maxTempOne = Int(slider2.rightValue)
        minTempOneLbl.text = "\(mainSettingsData.minTempOne)"
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
        
        /*minTempOne.value = Float(mainSettingsData.minTempOne)
        maxTempOne.value = Float(mainSettingsData.maxTempOne)
        
        minTempOneLbl.text = "\(mainSettingsData.minTempOne)"
        maxTempOneLbl.text = "\(mainSettingsData.maxTempOne)"*/
        
        slider2.leftValue = Float(mainSettingsData.minTempOne)
        slider2.rightValue = Float(mainSettingsData.maxTempOne)
        
        minTempOneLbl.text = "\(mainSettingsData.minTempOne)"
        maxTempOneLbl.text = "\(mainSettingsData.maxTempOne)"
        
        //var image = UIImage(named: "roundedLeftThumb")!.withRenderingMode(.alwaysTemplate)
        //self.slider2?.setImage(image, forElement: .leftThumb, forControlState: UIControlState())
        self.slider2?.setTint(UIColor.red, forElement: .leftThumb, forControlState: UIControlState())
        self.slider2?.setTint(UIColor.gray, forElement: .leftThumb, forControlState: .disabled)
        
        //image = UIImage(named: "roundedRightThumb")!.withRenderingMode(.alwaysTemplate)
        //self.slider2?.setImage(image, forElement: .rightThumb, forControlState: UIControlState())
        self.slider2?.setTint(UIColor.red, forElement: .rightThumb, forControlState: UIControlState())
        self.slider2?.setTint(UIColor.gray, forElement: .rightThumb, forControlState: .disabled)
        
        self.slider2?.setTint(UIColor.red, forElement: .activeBar, forControlState: UIControlState())
        self.slider2?.setTint(UIColor.gray, forElement: .activeBar, forControlState: .disabled)
        
        //self.slider2?.setTint(UIColor.clear, forElement: .middleThumb, forControlState: UIControlState())
        
        self.slider2?.setTint(UIColor.lightGray, forElement: .inactiveBar, forControlState: .disabled)
        
        //self.slider2!.barHeight = 2.0

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}

