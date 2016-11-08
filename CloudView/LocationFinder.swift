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
    
    static func requestLocations(_ startDate: String, endDate: String, dataSet: String, dataType: String, completionHandler: @escaping ([String:String]) -> ()) {
        
        self.makeCategoryCall(startDate, endDate: endDate, dataSet: dataSet, dataType: dataType, completionHandler: completionHandler)
        
    }
    
    
    static func makeCategoryCall(_ startDate: String, endDate: String, dataSet: String, dataType: String, completionHandler: @escaping ([String:String]) -> ()) {
        
        print("\(mainSettingsData.bottomLeftLat), \(mainSettingsData.bottomLeftLon), \(mainSettingsData.topRightLat), \(mainSettingsData.topRightLon)")
        
        var results: [[String:AnyObject]] = [[:]]
        var dict: [String:String] = [:]
        
        
        let headers = [
            "token": "qMbhulVTJqFjFMUdHrwmhbxVyIIeqmOs"
        ]
        
        
        let parameters = [
            
            "limit": "100",
            "extent" : "\(mainSettingsData.topRightLat), \(mainSettingsData.topRightLon), \(mainSettingsData.bottomLeftLat), \(mainSettingsData.bottomLeftLon)"
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
                print("blueee...42... \(responseData.data)")
                switch responseData.result {
                case .success:
                    print("Validation Successful \(startDate)")
                    let swiftyJsonVar = JSON(responseData.result.value!)
                      print(swiftyJsonVar)
                    
                    if let resData = swiftyJsonVar["results"].arrayObject {
                        print(resData)
                        results = resData as! [[String:AnyObject]]
                        //  print(arrayVar)
                        print(results)
                        
                        var stationFiles = [NOAAStationFile]()
                        for item in results {
                            if let stationFile = NOAAStationFile(json: item) {
                                stationFiles.append(stationFile)
                            }
                        }
                        mainSettingsData.stationFile = stationFiles
                        for i in stationFiles {
                            print("\(i.name) has id \(i.stationID)")
                        }
                        
                        for i in results {
                            if let name = i["name"], let stationID = i["id"] {
                                let stringOfName = "\(name)"
                                let stringOfStationID = "\(stationID)"
                                print(stringOfName)
                                //array.append(stringOfName)
                                dict[stringOfName] = stringOfStationID
                                
                            }
                        }
                        //print(array)
                        completionHandler(dict)
                        
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
    
    private func nOAAStationFileArrayFromResponse(response: DataResponse<Any>) -> Result<[NOAAStationFile]> {
        guard response.result.error == nil else {
            print(response.result.error!)
            return .failure(GitHubAPIManagerError.network(error: response.result.error!))
        }
        
        // make sure we got JSON and it's an array
        guard let jsonArray = response.result.value as? [[String: Any]] else {
            print("didn't get array of gists object as JSON from API")
            return .failure(GitHubAPIManagerError.objectSerialization(reason:
                "Did not get JSON dictionary in response"))
        }
        
        // check for "message" errors in the JSON because this API does that
        if let jsonDictionary = response.result.value as? [String: Any],
            let errorMessage = jsonDictionary["message"] as? String {
            return .failure(GitHubAPIManagerError.apiProvidedError(reason: errorMessage))
        }
        
        // turn JSON in to gists
        var nOAAStationFiles = [NOAAStationFile]()
        for item in jsonArray {
            if let nOAAStationFile = NOAAStationFile(json: item) {
                nOAAStationFiles.append(nOAAStationFile)
            }
        }
        return .success(nOAAStationFiles)
    }

}
