//
//  FetchAllData.swift
//  NOAA
//
//  Created by Julian Post on 9/14/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import UIKit
import GooglePlaces

class FetchAllData {
    
    static func getLatLon(viewOne: UIView, viewTwo: UIView, viewThree: UIView, placesClient: GMSPlacesClient) {
        
        placesClient.currentPlace(callback: {
            (placeLikelihoodList: GMSPlaceLikelihoodList?, error: Error?) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
           
            
            if let placeLikelihoodList = placeLikelihoodList {
                if let place = placeLikelihoodList.likelihoods.first?.place {
                    
                    mainSettingsData.latitude = "\(place.coordinate.latitude)"
                    mainSettingsData.longitude = "\(place.coordinate.longitude)"
                    mainSettingsData.bottomLeftLat = "\(place.coordinate.latitude + 0.1)"
                    mainSettingsData.bottomLeftLon = "\(place.coordinate.longitude + 0.1)"
                    mainSettingsData.topRightLat = "\(place.coordinate.latitude - 0.1)"
                    mainSettingsData.topRightLon = "\(place.coordinate.longitude - 0.1)"
                    
                    print(mainSettingsData.latitude)
                    print(mainSettingsData.longitude)
                }
                
            }
            
            //FetchAllData.getStation(viewOne: viewOne, viewTwo: viewTwo, viewThree: viewThree)
        })
    }
}

/*  while date.compare(dateFor.currentWeekEnd) != ComparisonResult.orderedSame {
 
 
 // aPIClient.getForecast(latitude: 44.4759, longitude: -73.2121, time: date)
 
 CallREST.requestWeatherFromDarkSky("\(date.timeIntervalSince1970)", latitude: mainSettingsData.latitude, longitude: mainSettingsData.longitude) { responseObject in
 
 print(responseObject)
 }
 
 
 // increment the date by 1 day
 let userCalendar = Calendar.current
 var dateComponents = DateComponents()
 dateComponents.day = 1
 date = userCalendar.date(byAdding: dateComponents, to: date)!
 
 }
 */
