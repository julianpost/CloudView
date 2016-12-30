//
//  PrecipViewController.swift
//  NOAA
//
//  Created by Julian Post on 8/6/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import UIKit
import GooglePlaces


class PrecipViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var precipViewOne: UIView!
    @IBOutlet weak var precipViewTwo: UIView!
    @IBOutlet weak var precipViewThree: UIView!
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    @IBOutlet weak var topValue: UILabel!
    @IBOutlet weak var bottomValue: UILabel!
    
    var placesClient: GMSPlacesClient?
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        
        if let result = mainPrecipArray {
        switch sender.selectedSegmentIndex
        {
        case 0:
            topLabel.text = "Week total"
            bottomLabel.text = "Past 48 hours"
            topValue.text = result.weekTotalPrecip
            bottomValue.text = result.fortyEightHourPrecip
            precipViewOne.layer.isHidden = false
            precipViewTwo.layer.isHidden = true
            precipViewThree.layer.isHidden = true
            
           /* weekTotalPrecip.layer.isHidden = false
            fortyEightHourPrecip.layer.isHidden = false
            monthTotalPrecip.layer.isHidden = true
            avgMonthByNow.layer.isHidden = true
            seasonTotalPrecip.layer.isHidden = true
            avgSeasonByNow.layer.isHidden = true*/
            
            
        case 1:
            topLabel.text = "Month total"
            bottomLabel.text = "This month by now"
            topValue.text = result.monthTotalPrecip
            bottomValue.text = "TBC"
            precipViewOne.layer.isHidden = true
            precipViewTwo.layer.isHidden = false
            precipViewThree.layer.isHidden = true
            
            /*weekTotalPrecip.layer.isHidden = true
            fortyEightHourPrecip.layer.isHidden = true
            monthTotalPrecip.layer.isHidden = false
            avgMonthByNow.layer.isHidden = false
            seasonTotalPrecip.layer.isHidden = true
            avgSeasonByNow.layer.isHidden = true*/
           
            
        case 2:
            topLabel.text = "Season total"
            bottomLabel.text = "This season by now"
            topValue.text = result.seasonTotalPrecip
            bottomValue.text = "TBC"
            precipViewOne.layer.isHidden = true
            precipViewTwo.layer.isHidden = true
            precipViewThree.layer.isHidden = false
            
           /* weekTotalPrecip.layer.isHidden = true
            fortyEightHourPrecip.layer.isHidden = true
            monthTotalPrecip.layer.isHidden = true
            avgMonthByNow.layer.isHidden = true
            seasonTotalPrecip.layer.isHidden = false
            avgSeasonByNow.layer.isHidden = false*/
            
        default:
            topLabel.text = ""
            bottomLabel.text = ""
            topValue.text = ""
            bottomValue.text = ""
            precipViewOne.layer.isHidden = true
            precipViewTwo.layer.isHidden = true
            precipViewThree.layer.isHidden = true
            /*weekTotalPrecip.layer.isHidden = true
            fortyEightHourPrecip.layer.isHidden = true
            monthTotalPrecip.layer.isHidden = true
            avgMonthByNow.layer.isHidden = true
            seasonTotalPrecip.layer.isHidden = true
            avgSeasonByNow.layer.isHidden = true*/
            
        }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GMSPlacesClient.provideAPIKey("AIzaSyA3Flb3HdA0EjlxVoxnEMUesGSBKhM6r_s")
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        placesClient = GMSPlacesClient.shared()
        
        
        APIManager.sharedInstance.fetchPrecip() { result in
            
           UpdateView.handlePrecipCompletion(self.precipViewOne, viewTwo: self.precipViewTwo, viewThree: self.precipViewThree, precip: result)
            
        mainPrecipArray = result
            
        UpdateView.drawMonthBars(self.precipViewTwo, observations: result)
        UpdateView.drawWeekBars(self.precipViewOne, observations: result)
            
        self.topLabel.text = "Week total"
        self.bottomLabel.text = "Past 48 hours"
        self.topValue.text = result.weekTotalPrecip
        self.bottomValue.text = result.fortyEightHourPrecip
            
        }
        
        precipViewOne.layer.isHidden = false
        precipViewTwo.layer.isHidden = true
        precipViewThree.layer.isHidden = true
        
        /*weekTotalPrecip.layer.isHidden = false
        fortyEightHourPrecip.layer.isHidden = false
        monthTotalPrecip.layer.isHidden = true
        avgMonthByNow.layer.isHidden = true
        seasonTotalPrecip.layer.isHidden = true
        avgSeasonByNow.layer.isHidden = true*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
          }
        else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func handleLoadGistsError(_ error: Error) { // TODO: show error
        
    }
}
