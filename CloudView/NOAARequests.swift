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

    static func requestWeatherFromNOAA(_ routerURL: URLRequestConvertible, completionHandler: @escaping ([Date:Float]) -> ()) {
        
        self.makeCall(routerURL, completionHandler: completionHandler)
        
    }
    
    
    static func makeCall(_ routerURL: URLRequestConvertible, completionHandler: @escaping ([Date:Float]) -> ()) {
        
        var array: [[String:AnyObject]] = [[:]]
        var dict: [Date:Float] = [:]
        
        
        
        Alamofire.request(routerURL)
            .validate(statusCode: 200..<300).responseJSON { (responseData) -> Void in
                //debugPrint(responseData)
                switch responseData.result {
                case .success:
                    print("Validation Successful")
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
                    }
                    
                    
                case .failure(let error):
                    print(error)
                }
                
        }

    }
    
    static func requestWeatherFromDarkSky(_ routerURL: URLRequestConvertible, completionHandler: @escaping ([Date:Float]) -> ()) {
        
        self.makeDarkSkyCall(routerURL, completionHandler: completionHandler)
        
    }
    
    
    static func makeDarkSkyCall(_ routerURL: URLRequestConvertible, completionHandler: @escaping ([Date:Float]) -> ()) {
        
        var array: [[String:AnyObject]] = [[:]]
        var dict: [Date:Float] = [:]
        
        
       Alamofire.request(routerURL)
            .responseJSON { (responseData) -> Void in
                //debugPrint(responseData)
                switch responseData.result {
                case .success:
                    print("Validation Successful")
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
                    }
                    
                    
                case .failure(let error):
                    print(error)
                }
     
        }
        
    }
    
}
