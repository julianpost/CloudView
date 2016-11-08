//
//  APIManager.swift
//  CloudView
//
//  Created by Julian Post on 11/3/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import Foundation
import Alamofire

enum GitHubAPIManagerError: Error {
    case network(error: Error)
    case apiProvidedError(reason: String)
    case authCouldNot(reason: String)
    case authLost(reason: String)
    case objectSerialization(reason: String)
}

class DSAPIManager {
    
    func getStations(_ startDate: String, endDate: String, dataSet: String, dataType: String, completionHandler: @escaping (Result<[NOAAStationFile]>) -> Void) {
        
        let headers = [
            "token": "qMbhulVTJqFjFMUdHrwmhbxVyIIeqmOs"
        ]
        
        
        let parameters = [
            
            "limit": "100",
            "extent" : "\(mainSettingsData.topRightLat), \(mainSettingsData.topRightLon), \(mainSettingsData.bottomLeftLat), \(mainSettingsData.bottomLeftLon)"
            
            ]
        
    Alamofire.request("https://www.ncdc.noaa.gov/cdo-web/api/v2/stations?", parameters: parameters, headers: headers)
    .validate(statusCode: 200..<300).responseJSON { response in
        if let urlResponse = response.response {
        let result = self.nOAAStationFileArrayFromResponse(response: response)
            print(result)
            completionHandler(result)
        }
        
    /*if let receivedResponse = response.result.value {
    nOAAStationFileArrayFromResponse(response: receivedResponse)
    }*/
    }
    
}


    // MARK: - API Calls
  /*  func fetchDSWeather(completionHandler: @escaping (Result<[DSObservations]>, String?) -> Void) {
        Alamofire.request("https://api.darksky.net/forecast/926af8e65c308d15a6f1c76a09e24631/\(mainSettingsData.latitude),\(mainSettingsData.longitude),\(Date().timeIntervalSince1970)")
            .responseJSON { response in
                // if let urlResponse = response.response,
                /*let authError = self.checkUnauthorized(urlResponse: urlResponse) {
                 completionHandler(.failure(authError), nil)
                 return
                 }*/
                let result = self.dSWeatherArrayFromResponse(response: response)
                let next = self.parseNextPageFromHeaders(response: response.response)
                completionHandler(result, next)
        }
    }

    // MARK: - Helpers
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
    }*/
    
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

   /* private func dSWeatherArrayFromResponse(response: DataResponse<Any>) -> Result<[DSObservations]> {
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
        var dSWeathers = [DSObservations]()
        for item in jsonArray {
            if let dSWeather = DSObservations(json: item) {
                dSWeathers.append(dSWeather)
            }
        }
        return .success(dSWeathers)
    }
    */
    
  /*  func isAPIOnline(completionHandler: @escaping (Bool) -> Void) {
        Alamofire.request(WeatherRouter.baseURLString)
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
