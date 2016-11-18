//
//  DarkSkyRouter.swift
//  CloudView
//
//  Created by Julian Post on 11/17/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import Foundation
import Alamofire

enum DarkSkyRouter: URLRequestConvertible {
    static let baseURLString = "https://api.darksky.net/forecast/926af8e65c308d15a6f1c76a09e24631/"
    
    case getCurrentYearPrecip()
    case getNormalYearPrecip()
    case getCurrentYearTMax()
    case getNormalYearTMax()
    case getCurrentYearTMin()
    case getNormalYearTMin()
    
    case completeCurrentYearPrecip()
    case completeNormalYearPrecip()
    case completeCurrentYearTMax()
    case completeNormalYearTMax()
    case completeCurrentYearTMin()
    case completeNormalYearTMin()
    
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self {
            case .getCurrentYearPrecip, .getNormalYearPrecip, .getCurrentYearTMax, .getNormalYearTMax, .getCurrentYearTMin, .getNormalYearTMin, .completeCurrentYearPrecip, .completeNormalYearPrecip, .completeCurrentYearTMax, .completeNormalYearTMax, .completeCurrentYearTMin, .completeNormalYearTMin:
                return .get
            }
        }
        
        let url: URL = {
            let relativePath: String
            switch self {
            case .getCurrentYearPrecip, .getNormalYearPrecip, .getCurrentYearTMax, .getNormalYearTMax, .getCurrentYearTMin, .getNormalYearTMin, .completeCurrentYearPrecip, .completeNormalYearPrecip, .completeCurrentYearTMax, .completeNormalYearTMax, .completeCurrentYearTMin, .completeNormalYearTMin:
                relativePath = "latitude/longitude/time"
            }
            
            var url = URL(string: NOAARouter.baseURLString)!
            url.appendPathComponent(relativePath)
            return url
        }()
        
        let params: ([String: Any]?) = {
            switch self {
            case .getCurrentYearPrecip, .getNormalYearPrecip, .getCurrentYearTMax, .getNormalYearTMax, .getCurrentYearTMin, .getNormalYearTMin, .completeCurrentYearPrecip, .completeNormalYearPrecip, .completeCurrentYearTMax, .completeNormalYearTMax, .completeCurrentYearTMin, .completeNormalYearTMin:
                return ([
                    "exclude" : "currently,minutely,hourly,alerts,flags",
                    "units" : "us",
                    "lang" : "en"
                    ])
            }
        }()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        let encoding = URLEncoding.default
        return try encoding.encode(urlRequest, with: params)
    }
}
