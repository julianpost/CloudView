//
//  LocationFinder.swift
//  NOAA
//
//  Created by Julian Post on 10/15/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import GooglePlaces

class CallForLocations {
    
    
    
    static func makeGoogleCall(_ startDate: String, endDate: String, dataSet: String, dataType: String, zipCode: String, completionHandler: @escaping ([String]) -> ()) {
        
        
        
        //let googleAPIKey = "AIzaSyA3Flb3HdA0EjlxVoxnEMUesGSBKhM6r_s"
        var dict: [[String:AnyObject]] = [[:]]
        var array: [String] = []
        
        
        let headers = [
            "token": "qMbhulVTJqFjFMUdHrwmhbxVyIIeqmOs"
        ]
        
        
        let parameters = [
            
            "limit": "20",
            //"datatypeid": dataType,
            //"datasetid" : "GHCND",
            //"startdate": startDate,
            //"enddate" : endDate,
            //"locationcategoryid" : "ST",
            //"sortfield" : "name",
            //"sortorder" : "asc",
            //"locationcategoryid" : "ZIP:\(zipCode)"
            //"datasetid" : dataSet,
        ]
        
        
        Alamofire.request("https://www.googleapis.com/geolocation/v1/geolocate?key=", headers: headers)
            .validate(statusCode: 200..<300).responseJSON { (responseData) -> Void in
                debugPrint(responseData)
                switch responseData.result {
                case .success:
                    print("Validation Successful \(startDate)")
                    let swiftyJsonVar = JSON(responseData.result.value!)
                    print(swiftyJsonVar)
                    
                    if let resData = swiftyJsonVar["results"].arrayObject {
                        print(resData)
                        dict = resData as! [[String:AnyObject]]
                        //  print(arrayVar)
                        print(dict)
                        
                        for i in dict {
                            if let name = i["name"] {
                                let stringOfName = "\(name)"
                                print(stringOfName)
                                array.append(stringOfName)
                                
                            }
                        }
                        print(array)
                        completionHandler(array)
                        
                    }
                    
                    
                case .failure(let error):
                    print(error)
                }
                
                
                
                
        }
        
    }

    
    
    
    
    
    
    static func requestLocations(_ startDate: String, endDate: String, dataSet: String, dataType: String, zipCode: String, completionHandler: @escaping ([String]) -> ()) {
        
        self.makeCategoryCall(startDate, endDate: endDate, dataSet: dataSet, dataType: dataType, zipCode: zipCode, completionHandler: completionHandler)
        
    }
    
    
    static func makeCategoryCall(_ startDate: String, endDate: String, dataSet: String, dataType: String, zipCode: String, completionHandler: @escaping ([String]) -> ()) {
        
        var dict: [[String:AnyObject]] = [[:]]
        var array: [String] = []
        
        
        let headers = [
            "token": "qMbhulVTJqFjFMUdHrwmhbxVyIIeqmOs"
        ]
        
        
        let parameters = [
            
            "limit": "20",
            "extent" : mainSettingsData.extent
            //"datatypeid": dataType,
            //"datasetid" : "GHCND",
            //"startdate": startDate,
            //"enddate" : endDate,
            //"locationcategoryid" : "ST",
            //"sortfield" : "name",
            //"sortorder" : "asc",
            //"locationcategoryid" : "ZIP:\(zipCode)"
            //"datasetid" : dataSet,
        ]
        
        
        Alamofire.request("https://www.ncdc.noaa.gov/cdo-web/api/v2/stations?", parameters: parameters, headers: headers)
            .validate(statusCode: 200..<300).responseJSON { (responseData) -> Void in
                debugPrint(responseData)
                switch responseData.result {
                case .success:
                    print("Validation Successful \(startDate)")
                    let swiftyJsonVar = JSON(responseData.result.value!)
                      print(swiftyJsonVar)
                    
                    if let resData = swiftyJsonVar["results"].arrayObject {
                        print(resData)
                        dict = resData as! [[String:AnyObject]]
                        //  print(arrayVar)
                        print(dict)
                        
                        for i in dict {
                            if let name = i["name"] {
                                let stringOfName = "\(name)"
                                print(stringOfName)
                                array.append(stringOfName)
                                
                            }
                        }
                        print(array)
                        completionHandler(array)
                        
                    }
                    
                    
                case .failure(let error):
                    print(error)
                }
                
                
                
                
        }
        
    }
    
    
    static func requestLocationCategories(_ startDate: String, endDate: String, dataSet: String, dataType: String, completionHandler: @escaping ([String:String]) -> ()) {
        
        self.makeCall(startDate, endDate: endDate, dataSet: dataSet, dataType: dataType, completionHandler: completionHandler)
        
    }
    
    
    static func makeCall(_ startDate: String, endDate: String, dataSet: String, dataType: String, completionHandler: @escaping ([String:String]) -> ()) {
        
        var array: [[String:AnyObject]] = [[:]]
        var dict: [String:String] = [:]
        
        
        let headers = [
            "token": "qMbhulVTJqFjFMUdHrwmhbxVyIIeqmOs"
        ]
        
        
        let parameters = [
            
            "limit": "20",
            "datatypeid": dataType,
            "startdate": startDate,
            "enddate" : endDate,
            //"datasetid" : dataSet,
        ]
        
        
        Alamofire.request("https://www.ncdc.noaa.gov/cdo-web/api/v2/locationcategories?datasetid=\(dataSet)", parameters: parameters, headers: headers)
            .validate(statusCode: 200..<300).responseJSON { (responseData) -> Void in
                debugPrint(responseData)
                switch responseData.result {
                case .success:
                    print("Validation Successful \(startDate)")
                    let swiftyJsonVar = JSON(responseData.result.value!)
                    //  print(swiftyJsonVar)
                    
                    if let resData = swiftyJsonVar["results"].arrayObject {
                        array = resData as! [[String:AnyObject]]
                          print(array)
                        
                        for i in array {
                            if let name = i["name"], let value = i["id"] {
                                let stringOfName = "\(name)"
                                let stringOfValue = "\(value)"
                                dict[stringOfName] = stringOfValue
                                
                            }
                        }
                        
                        completionHandler(dict)
                        
                        //currentYearDict = dict
                        //mainWeatherData.currentYearPrecipArray = TransformArray.toSimple(dict)
                        //mainWeatherData.currentMonthPrecipArray = TransformArray.toCurrentMonth(dict)
                        //mainWeatherData.currentWeekPrecipArray = TransformArray.toCurrentWeek(dict)
                        //mainWeatherData.currentPrecipLoaded = true
                        //print(mainWeatherData.currentYearPrecipArray.count)
                        //UpdateView.handlePrecipCompletion(view)
                    }
                    
                    
                case .failure(let error):
                    print(error)
                }
                
                
                
                
        }
        
    }


}
