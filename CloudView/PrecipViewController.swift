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
    
    @IBOutlet weak var sundayBar: UIView!
    @IBOutlet weak var mondayBar: UIView!
    @IBOutlet weak var tuesdayBar: UIView!
    @IBOutlet weak var wednesdayBar: UIView!
    @IBOutlet weak var thursdayBar: UIView!
    @IBOutlet weak var fridayBar: UIView!
    @IBOutlet weak var saturdayBar: UIView!
    
    @IBOutlet weak var weekTotalPrecip: UILabel!
    @IBOutlet weak var fortyEightHourPrecip: UILabel!
    
    var gists = [NOAAStationFile]()
    
    var placesClient: GMSPlacesClient?
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    
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
        
        GMSPlacesClient.provideAPIKey("AIzaSyA3Flb3HdA0EjlxVoxnEMUesGSBKhM6r_s")
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        placesClient = GMSPlacesClient.shared()
        
        
        APIManager.sharedInstance.fetchPrecip() { result in
            
           UpdateView.handlePrecipCompletion(self.precipViewOne, viewTwo: self.precipViewTwo, viewThree: self.precipViewThree, precip: result)
            
            print(result.currentWeekPrecipArray)
            
            self.weekTotalPrecip.text = String(result.currentWeekPrecipArray.reduce(0, +)) + " inches"
            self.fortyEightHourPrecip.text = String(result.currentWeekPrecipArray[5]+result.currentWeekPrecipArray[6]) + " inches"
            
            if let maxThisWeek = result.currentWeekPrecipArray.max() {
                if result.currentWeekPrecipArray.count > 0 {
                    self.sundayBar.frame.size.height = self.precipViewOne.frame.size.height * CGFloat(result.currentWeekPrecipArray[0]/maxThisWeek + 0.01)
                    self.sundayBar.frame.origin.y = 300-self.sundayBar.frame.size.height
                }
                    
                else {
                    self.sundayBar.frame.size.height = CGFloat(0.05/maxThisWeek)
                    self.sundayBar.frame.origin.y = 300-self.sundayBar.frame.size.height
                }
            }
            
            if let maxThisWeek = result.currentWeekPrecipArray.max() {
                if result.currentWeekPrecipArray.count > 1 {
                    self.mondayBar.frame.size.height = self.precipViewOne.frame.size.height * CGFloat(result.currentWeekPrecipArray[1]/maxThisWeek + 0.01)
                    self.mondayBar.frame.origin.y = 300-self.mondayBar.frame.size.height
                }
                    
                else {
                    self.mondayBar.frame.size.height = CGFloat(0.01/maxThisWeek)
                    self.mondayBar.frame.origin.y = 300-self.mondayBar.frame.size.height
                }
            }
            
            if let maxThisWeek = result.currentWeekPrecipArray.max() {
                if result.currentWeekPrecipArray.count > 2 {
                    self.tuesdayBar.frame.size.height = self.precipViewOne.frame.size.height * CGFloat(result.currentWeekPrecipArray[2]/maxThisWeek + 0.01)
                    self.tuesdayBar.frame.origin.y = 300-self.tuesdayBar.frame.size.height
                }
                    
                else {
                    self.tuesdayBar.frame.size.height = CGFloat(0.01/maxThisWeek)
                    self.tuesdayBar.frame.origin.y = 300-self.tuesdayBar.frame.size.height
                }
            }
            
            if let maxThisWeek = result.currentWeekPrecipArray.max() {
                if result.currentWeekPrecipArray.count > 3 {
                    self.wednesdayBar.frame.size.height = self.precipViewOne.frame.size.height * CGFloat(result.currentWeekPrecipArray[3]/maxThisWeek + 0.01)
                    self.wednesdayBar.frame.origin.y = 300-self.wednesdayBar.frame.size.height
                }
                    
                else {
                    self.wednesdayBar.frame.size.height = CGFloat(0.01/maxThisWeek)
                    self.wednesdayBar.frame.origin.y = 300-self.wednesdayBar.frame.size.height
                }
            }
            
            if let maxThisWeek = result.currentWeekPrecipArray.max() {
                if result.currentWeekPrecipArray.count > 4 {
                    self.thursdayBar.frame.size.height = self.precipViewOne.frame.size.height * CGFloat(result.currentWeekPrecipArray[4]/maxThisWeek + 0.01)
                    self.thursdayBar.frame.origin.y = 300-self.thursdayBar.frame.size.height
                }
                    
                else {
                    self.thursdayBar.frame.size.height = CGFloat(0.01/maxThisWeek)
                    self.thursdayBar.frame.origin.y = 300-self.thursdayBar.frame.size.height
                }
            }
            
            if let maxThisWeek = result.currentWeekPrecipArray.max() {
                if result.currentWeekPrecipArray.count > 5 {
                    self.fridayBar.frame.size.height = self.precipViewOne.frame.size.height * CGFloat(result.currentWeekPrecipArray[5]/maxThisWeek + 0.01)
                    self.fridayBar.frame.origin.y = 300-self.fridayBar.frame.size.height
                }
                    
                else {
                    self.fridayBar.frame.size.height = CGFloat(0.01/maxThisWeek)
                    self.fridayBar.frame.origin.y = 300-self.fridayBar.frame.size.height
                }
            }
            
            if let maxThisWeek = result.currentWeekPrecipArray.max() {
                if result.currentWeekPrecipArray.count > 6 {
                    self.saturdayBar.frame.size.height = self.precipViewOne.frame.size.height * CGFloat(result.currentWeekPrecipArray[6]/maxThisWeek + 0.01)
                    self.saturdayBar.frame.origin.y = 300-self.saturdayBar.frame.size.height
                }
                    
                else {
                    self.saturdayBar.frame.size.height = CGFloat(0.01/maxThisWeek)
                    self.saturdayBar.frame.origin.y = 300-self.saturdayBar.frame.size.height
                }
            }
        }
        
       /* // Instantiate a new PrecipWeekView object (inherits and has all properties of UIView)
        let k = PrecipWeekView(frame: CGRect(x: 75, y: 75, width: 150, height: 150))
        
        // Put the rectangle in the canvas in this new object
        k.draw(CGRect(x: 10, y: 50, width: 20, height: 100))
        k.draw(CGRect(x: 100, y: 50, width: 20, height: 100))
        
        // view: UIView was created earlier using StoryBoard
        // Display the contents (our rectangle) by attaching it
        self.precipViewOne.addSubview(k)
        
         */
        
        
        precipViewOne.layer.isHidden = false
        precipViewTwo.layer.isHidden = true
        precipViewThree.layer.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            /*currentWeather.downloadWeatherDetails {
                self.downloadForecastData {
                    self.updateMainUI()
                }
            }*/
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
   /* func loadStuff () {
        APIManager.sharedInstance.fetchPublicGists() {
            result in
            guard result.error == nil else {
                self.handleLoadGistsError(result.error!)
                return
            }
            if let fetchedGists = result.value {
                self.gists = fetchedGists
            print("YO WHAT UP \(self.gists)")}
             }
    }*/
    
    func handleLoadGistsError(_ error: Error) { // TODO: show error
    }

    

}
