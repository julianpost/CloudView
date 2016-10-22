//
//  PrecipViewController.swift
//  NOAA
//
//  Created by Julian Post on 8/6/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import UIKit


class PrecipViewController: UIViewController {
    
    
    @IBOutlet weak var precipViewOne: UIView!
    @IBOutlet weak var precipViewTwo: UIView!
    @IBOutlet weak var precipViewThree: UIView!
    
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex
        {
        case 0:
            precipViewOne.layer.isHidden = false
            precipViewTwo.layer.isHidden = true
            precipViewThree.layer.isHidden = true
            
        case 1:
            precipViewOne.layer.isHidden = true
            precipViewTwo.layer.isHidden = false
            precipViewThree.layer.isHidden = true
            
        case 2:
            precipViewOne.layer.isHidden = true
            precipViewTwo.layer.isHidden = true
            precipViewThree.layer.isHidden = false
            
        default:
            precipViewOne.layer.isHidden = true
            precipViewTwo.layer.isHidden = true
            precipViewThree.layer.isHidden = true
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FetchAllData.precip(precipViewOne, viewTwo: precipViewTwo, viewThree: precipViewThree)
        
        precipViewOne.layer.isHidden = true
        precipViewTwo.layer.isHidden = true
        precipViewThree.layer.isHidden = false
        
      /*  CallForLocations.requestLocationCategories(dateFor.stringOfNormalYearStart, endDate: dateFor.stringOfNormalYearEnd, dataSet: "GHCND", dataType: "PRCP")  { responseObject in
            // use responseObject and error here
            print(responseObject)
           
            
            return
        }*/
        
        /*CallForLocations.requestLocations(dateFor.stringOfNormalYearStart, endDate: dateFor.stringOfNormalYearEnd, dataSet: "GHCND", dataType: "PRCP", zipCode: "05401")  { responseObject in
            // use responseObject and error here
            print(responseObject)
            
            
            return
        }*/

        
        //UpdateView.drawChart(self.precipView, current: mainWeatherData.currentMonthPrecipArray, normal: mainWeatherData.normalMonthPrecipArray)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
