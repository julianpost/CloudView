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
    
    var placesClient: GMSPlacesClient?
    let locationManager = CLLocationManager()
    
    
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
        
        FetchAllData.getLatLon(viewOne: precipViewOne, viewTwo: precipViewTwo, viewThree: precipViewThree, placesClient: placesClient!)
        
        /*placesClient?.currentPlace(callback: {
            (placeLikelihoodList: GMSPlaceLikelihoodList?, error: Error?) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            
            if let placeLikelihoodList = placeLikelihoodList {
                if let place = placeLikelihoodList.likelihoods.first?.place {
                    
                    mainSettingsData.latitude = "\(place.coordinate.latitude)"
                    mainSettingsData.longitude = "\(place.coordinate.longitude)"
                    
                    print(mainSettingsData.latitude)
                    print(mainSettingsData.longitude)
                }
                
            }
            FetchAllData.precip(self.precipViewOne, viewTwo: self.precipViewTwo, viewThree: self.precipViewThree)
        }) */

        
        //FetchAllData.precip(precipViewOne, viewTwo: precipViewTwo, viewThree: precipViewThree)
        
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
