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
    
    @IBOutlet weak var minTempOneLbl: UILabel!
    @IBOutlet weak var maxTempOneLbl: UILabel!
    
    @IBOutlet var slider2: UIXRangeSlider!
    
    var tempData: NOAATempArrays?
    
    @IBAction func sliderChanged() {
        
        mainSettingsData.minTempOne = Int(slider2.leftValue)
        mainSettingsData.maxTempOne = Int(slider2.rightValue)
        minTempOneLbl.text = "\(mainSettingsData.minTempOne)"
        maxTempOneLbl.text = "\(mainSettingsData.maxTempOne)"
        
        updateChart()
    }
    
    @IBAction func dismissView(_ sender: AnyObject) {
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if mainTempArray == nil {
            APIManager.sharedInstance.fetchTemp() { result in
                UpdateView.handleTempCompletion(self.tempViewOne, temp: result)
                mainTempArray = result
            }
        }
        
        else {
            
            updateChart()
        
        }
        
        slider2.leftValue = Float(mainSettingsData.minTempOne)
        slider2.rightValue = Float(mainSettingsData.maxTempOne)
        minTempOneLbl.text = "\(mainSettingsData.minTempOne)"
        maxTempOneLbl.text = "\(mainSettingsData.maxTempOne)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func updateChart() {
        if let result = mainTempArray {
            mainTempArray?.currentYearDegreeDayOneCumulative = TransformArray.toCumulative(TransformArray.toDegreeDay(mainSettingsData.minTempOne, maxTemp: mainSettingsData.maxTempOne, tMin: result.currentYearTemperatureMinArray, tMax: result.currentYearTemperatureMaxArray))
            mainTempArray?.normalYearDegreeDayOneCumulative = TransformArray.toCumulative(TransformArray.toDegreeDay(mainSettingsData.minTempOne, maxTemp: mainSettingsData.maxTempOne, tMin: result.normalYearTemperatureMinArray, tMax: result.normalYearTemperatureMaxArray))
            UpdateView.handleTempCompletion(self.tempViewOne, temp: result)
        print("updated the chart")
        }
    }
}

