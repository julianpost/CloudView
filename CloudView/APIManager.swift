//
//  APIManager.swift
//  CloudView
//
//  Created by Julian Post on 11/3/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import Foundation
import Alamofire

enum APIManagerError: Error {
    case network(error: Error)
    case apiProvidedError(reason: String)
    case authCouldNot(reason: String)
    case authLost(reason: String)
    case objectSerialization(reason: String)
}

class APIManager {
    
    
    static let sharedInstance = APIManager()
    
    // MARK: - API Calls
    func getWeather() -> Void {
        Alamofire.request(NOAARouter.getNormalYearPrecip())
            .responseString { response in
                if let receivedString = response.result.value {
                    print(receivedString)
                }
        }
    }
    
    func fetchNOAAStuff(completionHandler: @escaping (Result<Any>) -> Void) {
        
        var precipCurrent: [Date:Float]
        var precipNormal: [[String:Any]]
        var tMaxCurrent: [[String:Any]]
        var tMaxNormal: [[String:Any]]
        var tMinCurrent: [[String:Any]]
        var tMinNormal: [[String:Any]]
        
        Alamofire.request(NOAARouter.getNormalYearPrecip())
        .responseJSON { response in
            
            precipCurrent = nOAAArrayFromResponse(response: response)
            
        }
    }
    
    func fetchGists(_ urlRequest: URLRequestConvertible, completionHandler: @escaping (Result<[NOAAStationFile]>, String?) -> Void) {
        Alamofire.request(urlRequest)
            .responseJSON { response in
                if let urlResponse = response.response,
                    let authError = self.checkUnauthorized(urlResponse: urlResponse) {
                    completionHandler(.failure(authError), nil)
                    return
                    }
                let result = self.gistArrayFromResponse(response: response)
                let next = self.parseNextPageFromHeaders(response: response.response)
                completionHandler(result, next)
                }
        }
    
       // MARK: - Helpers
   
    
    private func gistArrayFromResponse(response: DataResponse<Any>) -> Result<[NOAAStationFile]> {
        guard response.result.error == nil else {
            print(response.result.error!)
            return .failure(APIManagerError.network(error: response.result.error!))
        }
        
        // make sure we got JSON and it's an array
        guard let jsonArray = response.result.value as? [[String: Any]] else {
            print("didn't get array of gists object as JSON from API")
            return .failure(APIManagerError.objectSerialization(reason:
                "Did not get JSON dictionary in response"))
        }
        
        // check for "message" errors in the JSON because this API does that
        if let jsonDictionary = response.result.value as? [String: Any],
            let errorMessage = jsonDictionary["message"] as? String {
            return .failure(APIManagerError.apiProvidedError(reason: errorMessage))
        }
        
        // turn JSON in to gists
        var gists = [NOAAStationFile]()
        for item in jsonArray {
            if let gist = NOAAStationFile(json: item) {
                gists.append(gist)
            }
        }
        return .success(gists)
    }
        
    private func nOAAArrayFromResponse(response: DataResponse<Any>) -> Result<[Date : Float]> {
        guard response.result.error == nil else {
            print(response.result.error!)
            return .failure(APIManagerError.network(error: response.result.error!))
        }
        
        // make sure we got JSON and it's an array
        guard let jsonArray = response.result.value as? [String: Any] else {
            print("didn't get array of gists object as JSON from API")
            return .failure(APIManagerError.objectSerialization(reason:
                "Did not get JSON dictionary in response"))
        }
        
        // check for "message" errors in the JSON because this API does that
        if let jsonDictionary = response.result.value as? [String: Any],
            let errorMessage = jsonDictionary["message"] as? String {
            return .failure(APIManagerError.apiProvidedError(reason: errorMessage))
        }
        
        // turn JSON in to array
        
        var dict: [Date : Float]
        
            if let array = jsonArray["results"] as? [[String: Any]] {
            
                for i in array {
                    if let date = i["date"], let value = i["value"] {
                        let stringOfDate = "\(date)"
                        let formattedDate = DateFunctions.stringToDate(stringOfDate)
                        let stringOfValue = "\(value)"
                        let floatOfValue = Float(stringOfValue)
                        dict[formattedDate] = floatOfValue
                }
            }
        }
        return .success(dict)
    }
        
    func nOAAInitialParse(json: [String: Any]) -> [Date : Float] {
            
        var dict: [Date : Float]
        
        if let array = json["results"] as? [[String: Any]] {
                
            for i in array {
                if let date = i["date"], let value = i["value"] {
                    let stringOfDate = "\(date)"
                    let formattedDate = DateFunctions.stringToDate(stringOfDate)
                    let stringOfValue = "\(value)"
                    let floatOfValue = Float(stringOfValue)
                    dict[formattedDate] = floatOfValue
                        
                        
                }
            }
                
                
        }
            
        return dict
    }
    
    func checkUnauthorized(urlResponse: HTTPURLResponse) -> (Error?) {
        if (urlResponse.statusCode == 401) {
            //self.OAuthToken = nil
            return APIManagerError.authLost(reason: "Not Logged In")
        }
        return nil
    }
    
    func isAPIOnline(completionHandler: @escaping (Bool) -> Void) {
        Alamofire.request(NOAARouter.baseURLString)
            .validate(statusCode: 200 ..< 300)
            .response { response in
                guard response.error == nil else {
                    // no internet connection or GitHub API is down
                    completionHandler(false)
                    return
                }
                completionHandler(true)
        }
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
}
