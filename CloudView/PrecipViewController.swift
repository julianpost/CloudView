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
    
    @IBOutlet weak var weekTotalPrecip: UILabel!
    @IBOutlet weak var fortyEightHourPrecip: UILabel!
    @IBOutlet weak var monthTotalPrecip: UILabel!
    @IBOutlet weak var avgMonthByNow: UILabel!
    @IBOutlet weak var seasonTotalPrecip: UILabel!
    @IBOutlet weak var avgSeasonByNow: UILabel!
    
    //var gists = [NOAAStationFile]()
    
    var placesClient: GMSPlacesClient?
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex
        {
        case 0:
            topLabel.text = "Week total"
            bottomLabel.text = "Past 48 hours"
            precipViewOne.layer.isHidden = false
            precipViewTwo.layer.isHidden = true
            precipViewThree.layer.isHidden = true
            
            weekTotalPrecip.layer.isHidden = false
            fortyEightHourPrecip.layer.isHidden = false
            monthTotalPrecip.layer.isHidden = true
            avgMonthByNow.layer.isHidden = true
            seasonTotalPrecip.layer.isHidden = true
            avgSeasonByNow.layer.isHidden = true
            
            
        case 1:
            topLabel.text = "Month total"
            bottomLabel.text = "This month by now"
            precipViewOne.layer.isHidden = true
            precipViewTwo.layer.isHidden = false
            precipViewThree.layer.isHidden = true
            
            weekTotalPrecip.layer.isHidden = true
            fortyEightHourPrecip.layer.isHidden = true
            monthTotalPrecip.layer.isHidden = false
            avgMonthByNow.layer.isHidden = false
            seasonTotalPrecip.layer.isHidden = true
            avgSeasonByNow.layer.isHidden = true
           
            
        case 2:
            topLabel.text = "Season total"
            bottomLabel.text = "This season by now"
            precipViewOne.layer.isHidden = true
            precipViewTwo.layer.isHidden = true
            precipViewThree.layer.isHidden = false
            
            weekTotalPrecip.layer.isHidden = true
            fortyEightHourPrecip.layer.isHidden = true
            monthTotalPrecip.layer.isHidden = true
            avgMonthByNow.layer.isHidden = true
            seasonTotalPrecip.layer.isHidden = false
            avgSeasonByNow.layer.isHidden = false
            
            
        default:
            topLabel.text = ""
            bottomLabel.text = ""
            precipViewOne.layer.isHidden = true
            precipViewTwo.layer.isHidden = true
            precipViewThree.layer.isHidden = true
            weekTotalPrecip.layer.isHidden = true
            fortyEightHourPrecip.layer.isHidden = true
            monthTotalPrecip.layer.isHidden = true
            avgMonthByNow.layer.isHidden = true
            seasonTotalPrecip.layer.isHidden = true
            avgSeasonByNow.layer.isHidden = true
            
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
            
            print(result.currentWeekPrecipArray)
            
            self.weekTotalPrecip.text = String(result.currentWeekPrecipArray.reduce(0, +)) + " inches"
            self.fortyEightHourPrecip.text = String(result.currentWeekPrecipArray[5]+result.currentWeekPrecipArray[6]) + " inches"
            
            self.monthTotalPrecip.text = String(result.currentMonthPrecipArray.reduce(0, +)) + " inches"
            self.avgMonthByNow.text = "TBC"
            
            self.seasonTotalPrecip.text = String(result.currentYearPrecipArray.reduce(0, +)) + " inches"
            self.avgSeasonByNow.text = "TBC"
            
        UpdateView.drawMonthBars(self.precipViewTwo, observations: result)
        UpdateView.drawWeekBars(self.precipViewOne, observations: result)
            
        }
        
        precipViewOne.layer.isHidden = false
        precipViewTwo.layer.isHidden = true
        precipViewThree.layer.isHidden = true
        
        weekTotalPrecip.layer.isHidden = false
        fortyEightHourPrecip.layer.isHidden = false
        monthTotalPrecip.layer.isHidden = true
        avgMonthByNow.layer.isHidden = true
        seasonTotalPrecip.layer.isHidden = true
        avgSeasonByNow.layer.isHidden = true
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
