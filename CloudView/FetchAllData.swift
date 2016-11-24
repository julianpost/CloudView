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
            
            FetchAllData.getStation(viewOne: viewOne, viewTwo: viewTwo, viewThree: viewThree)
        })
        
    }
    
    static func getStation(viewOne: UIView, viewTwo: UIView, viewThree: UIView) {
        CallForLocations.requestLocations(dateFor.stringOfNormalYearStart, endDate: dateFor.stringOfNormalYearEnd , dataSet: "NORMAL_DLY", dataType: "YTD-PRCP-NORMAL") { responseObject in
            print(responseObject)
            return
        }
        
        //FetchAllData.precip(viewOne, viewTwo: viewTwo, viewThree: viewThree)
    
    }
    
    
  /*  static func precip(_ viewOne: UIView, viewTwo: UIView, viewThree: UIView) {

        //let formatter = DateFormatter()
        //formatter.dateFormat = "yyyy-MM-dd"
        //var date = dateFor.currentWeekStart
        
        
        
        CallREST.requestWeatherFromNOAA(NOAARouter.getCurrentYearPrecip())
        { responseObject in
            // use responseObject and error here
            //print(responseObject.count)
            mainWeatherData.currentYearPrecipDict = responseObject
            mainWeatherData.currentYearPrecipArray = TransformArray.toSimple(mainWeatherData.currentYearPrecipDict)
            mainWeatherData.currentYearPrecipCumulative = TransformArray.toCumulative(mainWeatherData.currentYearPrecipArray)
            //mainWeatherData.currentMonthPrecipArray = TransformArray.toCurrentMonth(mainWeatherData.currentYearPrecipDict)
            //mainWeatherData.currentWeekPrecipArray = TransformArray.toCurrentWeek(mainWeatherData.currentYearPrecipDict)
            mainWeatherData.currentPrecipLoaded = true
            UpdateView.handlePrecipCompletion(viewOne, viewTwo: viewTwo, viewThree: viewThree)
            
            return
        }
            
        
        CallREST.requestWeatherFromNOAA(NOAARouter.getNormalYearPrecip()) { responseObject in
            // use responseObject and error here
            mainWeatherData.normalYearPrecipDict = responseObject
            mainWeatherData.normalYearPrecipArray = TransformArray.toSimple(responseObject)
            //mainWeatherData.normalMonthPrecipArray = TransformArray.toNormalMonth(responseObject)
            //mainWeatherData.normalWeekPrecipArray = TransformArray.toNormalWeek(responseObject)
            mainWeatherData.normalPrecipLoaded = true
            UpdateView.handlePrecipCompletion(viewOne, viewTwo: viewTwo, viewThree: viewThree)
            //print("normal \(mainWeatherData.normalPrecipArray)")
            
            
            //print("responseObject = \(responseObject)")
            return
        }
        
    }
    
    static func temp(_ viewOne: UIView, viewTwo: UIView, viewThree: UIView) {
       
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        
        CallREST.requestWeatherFromNOAA(NOAARouter.getCurrentYearTMax()) { responseObject in
            // use responseObject and error here
            mainWeatherData.currentYearTemperatureMaxDict = responseObject
            mainWeatherData.currentYearTemperatureMaxArray = TransformArray.toSimple(responseObject)
            mainWeatherData.currentTMAXLoaded = true
            UpdateView.handleTempCompletion(viewOne, viewTwo: viewTwo, viewThree: viewThree)
            //print("CurrentMax\(mainWeatherData.currentYearTemperatureMaxArray)")

            return
        }
 
        CallREST.requestWeatherFromNOAA(NOAARouter.getCurrentYearTMin()) { responseObject in
            // use responseObject and error here
            mainWeatherData.currentYearTemperatureMinDict = responseObject
            mainWeatherData.currentYearTemperatureMinArray = TransformArray.toSimple(responseObject)
            mainWeatherData.currentTMINLoaded = true
            UpdateView.handleTempCompletion(viewOne, viewTwo: viewTwo, viewThree: viewThree)
            //print("CurrentMin\(mainWeatherData.currentYearTemperatureMinArray)")
 
            return
        }
 
 
        CallREST.requestWeatherFromNOAA(NOAARouter.getNormalYearTMax()) { responseObject in
            // use responseObject and error here
            
            mainWeatherData.normalYearTemperatureMaxDict = responseObject
            mainWeatherData.normalYearTemperatureMaxArray = TransformArray.toSimple(responseObject)
            mainWeatherData.normalMonthTemperatureMaxArray = TransformArray.toNormalMonth(responseObject)
            mainWeatherData.normalWeekTemperatureMaxArray = TransformArray.toNormalWeek(responseObject)
            mainWeatherData.normalTMAXLoaded = true
            UpdateView.handleTempCompletion(viewOne, viewTwo: viewTwo, viewThree: viewThree)
            //print("NormalMax\(mainWeatherData.normalYearTemperatureMaxArray)")

            return
        }
        
        CallREST.requestWeatherFromNOAA(NOAARouter.getNormalYearTMin()) { responseObject in
            // use responseObject and error here
            mainWeatherData.normalYearTemperatureMinDict = responseObject
            mainWeatherData.normalYearTemperatureMinArray = TransformArray.toSimple(responseObject)
            mainWeatherData.normalMonthTemperatureMinArray = TransformArray.toNormalMonth(responseObject)
            mainWeatherData.normalWeekTemperatureMinArray = TransformArray.toNormalWeek(responseObject)
            mainWeatherData.normalTMINLoaded = true
            UpdateView.handleTempCompletion(viewOne, viewTwo: viewTwo, viewThree: viewThree)
            //print("NormalMin\(mainWeatherData.normalYearTemperatureMinArray)")
          
            return
        }
        
    }*/

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
