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
            
            self.sundayBar.frame.size.height = self.precipViewOne.frame.size.height * CGFloat(result.currentWeekPrecipArray[0]/result.currentWeekPrecipArray.max()!)
            
            self.sundayBar.frame.origin.y = 300-self.sundayBar.frame.size.height
            
            self.mondayBar.frame.size.height = self.precipViewOne.frame.size.height * CGFloat(result.currentWeekPrecipArray[1]/result.currentWeekPrecipArray.max()!)
            
            self.mondayBar.frame.origin.y = 300-self.mondayBar.frame.size.height
            
            self.tuesdayBar.frame.size.height = self.precipViewOne.frame.size.height * CGFloat(result.currentWeekPrecipArray[2]/result.currentWeekPrecipArray.max()!)
            
            self.tuesdayBar.frame.origin.y = 300-self.tuesdayBar.frame.size.height
        }
        
        // Instantiate a new PrecipWeekView object (inherits and has all properties of UIView)
        let k = PrecipWeekView(frame: CGRect(x: 75, y: 75, width: 150, height: 150))
        
        // Put the rectangle in the canvas in this new object
        k.draw(CGRect(x: 10, y: 50, width: 20, height: 100))
        k.draw(CGRect(x: 100, y: 50, width: 20, height: 100))
        
        // view: UIView was created earlier using StoryBoard
        // Display the contents (our rectangle) by attaching it
        self.precipViewOne.addSubview(k)
        
        precipViewOne.layer.isHidden = true
        precipViewTwo.layer.isHidden = true
        precipViewThree.layer.isHidden = false
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
