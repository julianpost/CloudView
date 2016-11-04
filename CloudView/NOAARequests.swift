//
//  NOAARequests.swift
//  NOAA
//
//  Created by Julian Post on 7/25/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON






class CallREST {

    static func requestWeatherFromNOAA(_ startDate: String, endDate: String, dataSet: String, dataType: String, completionHandler: @escaping ([Date:Float]) -> ()) {
        
        self.makeCall(startDate, endDate: endDate, dataSet: dataSet, dataType: dataType, completionHandler: completionHandler)
        
    }
    
    
    static func makeCall(_ startDate: String, endDate: String, dataSet: String, dataType: String, completionHandler: @escaping ([Date:Float]) -> ()) {
        
        var array: [[String:AnyObject]] = [[:]]
        var dict: [Date:Float] = [:]
        
        
        let headers = [
            "token": "qMbhulVTJqFjFMUdHrwmhbxVyIIeqmOs"
        ]
        
        
        let parameters = [
            
            "limit": "365",
            "datatypeid": dataType,
            "startdate": startDate,
            "enddate" : endDate,
            //"datasetid" : dataSet,
            "stationid" : mainSettingsData.currentStation,
            "units" : "standard"
        ]
        
        
        Alamofire.request("https://www.ncdc.noaa.gov/cdo-web/api/v2/data?datasetid=\(dataSet)", parameters: parameters, headers: headers)
            .validate(statusCode: 200..<300).responseJSON { (responseData) -> Void in
                //debugPrint(responseData)
                switch responseData.result {
                case .success:
                    print("Validation Successful \(startDate)")
                    let swiftyJsonVar = JSON(responseData.result.value!)
                    //  print(swiftyJsonVar)
                    
                    if let resData = swiftyJsonVar["results"].arrayObject {
                        array = resData as! [[String:AnyObject]]
                        //  print(arrayVar)
                        
                        for i in array {
                            if let date = i["date"], let value = i["value"] {
                                let stringOfDate = "\(date)"
                                let formattedDate = DateFunctions.stringToDate(stringOfDate)
                                let stringOfValue = "\(value)"
                                let floatOfValue = Float(stringOfValue)
                                dict[formattedDate] = floatOfValue
                                
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
    
    /*static func requestWeatherFromDarkSky(_ date: String, latitude: String, longitude: String, completionHandler: @escaping ([Date:Float]) -> ()) {
        
        self.makeDarkSkyCall(date, latitude: latitude, longitude: longitude, completionHandler: completionHandler)
        
    }
    
    
    static func makeDarkSkyCall(_ date: String, latitude: String, longitude: String, completionHandler: @escaping ([Date:Float]) -> ()) {
        
        var array: [[String:AnyObject]] = [[:]]
        var dict: [Date:Float] = [:]
        
        
      /*  let headers = [
            "token": "qMbhulVTJqFjFMUdHrwmhbxVyIIeqmOs"
        ]
        */
        
       /* let parameters = [
            
            "limit": "365",
            "datatypeid": dataType,
            "startdate": startDate,
            "enddate" : endDate,
            //"datasetid" : dataSet,
            "stationid" : mainSettingsData.currentStation,
            "units" : "standard"
        ]*/
        
        Alamofire.request("https://api.darksky.net/forecast/926af8e65c308d15a6f1c76a09e24631/\(latitude),\(longitude),\(date)").responseJSON { response in
            //print(response.request)  // original URL request
            //print(response.response) // HTTP URL response
            //print(response.data)     // server data
            //print(response.result)   // result of response serialization
            debugPrint(response)
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }*/
        
        
        
       /* Alamofire.request("https://api.darksky.net/forecast/926af8e65c308d15a6f1c76a09e24631/\(latitude),\(longitude),\(date)")
            responseJSON { (responseData) -> Void in
                //debugPrint(responseData)
                switch responseData.result {
                case .success:
                    print("Validation Successful \(date)")
                    let swiftyJsonVar = JSON(responseData.result.value!)
                    //  print(swiftyJsonVar)
                    
                    if let resData = swiftyJsonVar["results"].arrayObject {
                        array = resData as! [[String:AnyObject]]
                        //  print(arrayVar)
                        
                        for i in array {
                            if let date = i["date"], let value = i["value"] {
                                let stringOfDate = "\(date)"
                                let formattedDate = DateFunctions.stringToDate(stringOfDate)
                                let stringOfValue = "\(value)"
                                let floatOfValue = Float(stringOfValue)
                                dict[formattedDate] = floatOfValue
                                
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
        
    }*/


    
    func imageFrom(urlString: String,
                   completionHandler: @escaping (UIImage?, Error?) -> Void) {
        let _ = Alamofire.request(urlString)
            .response { dataResponse in
                // use the generic response serializer that returns Data
                guard let data = dataResponse.data else {
                    completionHandler(nil, dataResponse.error)
                    return
                }
                let image = UIImage(data: data)
                completionHandler(image, nil)
        }
    }
    
    private func gistArrayFromResponse(response: DataResponse<Any>) -> Result<[DSObservations]> {
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
            //return .failure(GitHubAPIManagerError.apiProvidedError(reason: errorMessage))
        }
        
        // turn JSON in to gists
        var observations = [DSObservations]()
        for item in jsonArray {
            if let observation = DSObservations(json: item) {
                observations.append(observation)
            }
        }
        return .success(observations)
    }
    
    // MARK: - Pagination
    private func parseNextPageFromHeaders(response: HTTPURLResponse?) -> String? {
        guard let linkHeader = response?.allHeaderFields["Link"] as? String else {
            return nil
        }
        /* looks like: <https://...?page=2>; rel="next", <https://...?page=6>; rel="last" */
        // so split on ","
        let components = linkHeader.characters.split { $0 == "," }.map { String($0) }
        // now we have 2 lines like '<https://...?page=2>; rel="next"'
        for item in components {
            // see if it's "next"
            let rangeOfNext = item.range(of: "rel=\"next\"", options: [])
            guard rangeOfNext != nil else {
                continue
            }
            // this is the "next" item, extract the URL
            let rangeOfPaddedURL = item.range(of: "<(.*)>;",
                                              options: .regularExpression,
                                              range: nil,
                                              locale: nil)
            guard let range = rangeOfPaddedURL else {
                return nil
            }
            let nextURL = item.substring(with: range)
            // strip off the < and >;
            let start = nextURL.index(range.lowerBound, offsetBy: 1)
            let end = nextURL.index(range.upperBound, offsetBy: -2)
            let trimmedRange = start ..< end
            return nextURL.substring(with: trimmedRange)
        }
        return nil
    }
    
    enum GitHubAPIManagerError: Error {
        case network(error: Error)
        case apiProvidedError(reason: String)
        case authCouldNot(reason: String)
        case authLost(reason: String)
        case objectSerialization(reason: String)
    }
    
  /*  func checkUnauthorized(urlResponse: HTTPURLResponse) -> (Error?) {
        if (urlResponse.statusCode == 401) {
            self.OAuthToken = nil
            return GitHubAPIManagerError.authLost(reason: "Not Logged In")
        }
        return nil
    }*/
    
  /*  func isAPIOnline(completionHandler: @escaping (Bool) -> Void) {
        Alamofire.request(GistRouter.baseURLString)
            .validate(statusCode: 200 ..< 300)
            .response { response in
                guard response.error == nil else {
                    // no internet connection or GitHub API is down
                    completionHandler(false)
                    return
                }
                completionHandler(true)
        }
    }*/
    
}
