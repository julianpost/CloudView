//
//  NOAARouter.swift
//  CloudView
//
//  Created by Julian Post on 11/2/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

//
//  NOAARouter.swift
//  grokSwiftREST
//
//  Created by Christina Moulton on 2016-10-29.
//  Copyright © 2016 Teak Mobile Inc. All rights reserved.
//

import Foundation
import Alamofire

enum NOAARouter: URLRequestConvertible {
    static let baseURLString = "https://www.ncdc.noaa.gov/cdo-web/api/v2/data?"
    
    case getCurrentYearPrecip()
    case getNormalYearPrecip()
    case getCurrentYearTMax()
    case getNormalYearTMax()
    case getCurrentYearTMin()
    case getNormalYearTMin()
    
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self {
            case .getCurrentYearPrecip, .getNormalYearPrecip, .getCurrentYearTMax, .getNormalYearTMax, .getCurrentYearTMin, .getNormalYearTMin:
                return .get
            }
        }
        
        let url: URL = {
            let relativePath: String
            switch self {
            case .getCurrentYearPrecip:
                relativePath = "datasetid=GHCND&datatypeid=PRCP&stationid=\(mainSettingsData.currentStation)&startdate=\(dateFor.stringOfCurrentYearStart)&enddate=\(dateFor.stringOfCurrentYearEnd)&units=standard&limit=365"
            case .getNormalYearPrecip():
                relativePath = "datasetid=NORMAL_DLY&datatypeid=YTD-PRCP-NORMAL&stationid=\(mainSettingsData.currentStation)&startdate=\(dateFor.stringOfNormalYearStart)&enddate=\(dateFor.stringOfNormalYearEnd)&units=standard&limit=365"
            case .getCurrentYearTMax():
                relativePath = "datasetid=GHCND&datatypeid=TMAX&stationid=\(mainSettingsData.currentStation)&startdate=\(dateFor.stringOfCurrentYearStart)&enddate=\(dateFor.stringOfCurrentYearEnd)&units=standard&limit=365"
            case .getNormalYearTMax():
                relativePath = "datasetid=NORMAL_DLY&datatypeid=DLY-TMAX-NORMAL&stationid=\(mainSettingsData.currentStation)&startdate=\(dateFor.stringOfNormalYearStart)&enddate=\(dateFor.stringOfNormalYearEnd)&units=standard&limit=365"
            case .getCurrentYearTMin():
                relativePath = "datasetid=GHCND&datatypeid=TMIN&stationid=\(mainSettingsData.currentStation)&startdate=\(dateFor.stringOfCurrentYearStart)&enddate=\(dateFor.stringOfCurrentYearEnd)&units=standard&limit=365"
            case .getNormalYearTMin():
                relativePath = "datasetid=NORMAL_DLY&datatypeid=DLY-TMIN-NORMAL&stationid=\(mainSettingsData.currentStation)&startdate=\(dateFor.stringOfNormalYearStart)&enddate=\(dateFor.stringOfNormalYearEnd)&units=standard&limit=365"
            }
            
            var url = URL(string: NOAARouter.baseURLString)!
            url.appendPathComponent(relativePath)
            return url
        }()
        
        let params: ([String: Any]?) = {
            switch self {
            case .getCurrentYearPrecip, .getNormalYearPrecip, .getCurrentYearTMax, .getNormalYearTMax, .getCurrentYearTMin, .getNormalYearTMin:
                return nil
            }
        }()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        /*// Set OAuth token if we have one
        if let token = GitHubAPIManager.sharedInstance.OAuthToken {
            urlRequest.setValue("token \(token)", forHTTPHeaderField: "Authorization")
        }*/
        
        let encoding = JSONEncoding.default
        return try encoding.encode(urlRequest, with: params)
    }
}
