//
//  DSDaily.swift
//  CloudView
//
//  Created by Julian Post on 11/2/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import Foundation

class DSDaily: NSObject, NSCoding{
    var date: Date?
    var sunriseTime: Date?
    var sunsetTime: Date?
    var moonPhase: Float?
    var precipAccumulation: Float?
    var tMin: Float?
    var tMinTime: Date?
    var tMax: Float?
    var tMaxTime: Date?
    var dewPoint: Float?
    var humidity: Float?
    var windSpeed: Float?
    var windBearing: Float?
    var pressure: Float?
    
    required init?(json: [String: Any]) {
        
        let dateFormatter = DSObservations.dateFormatter()
        
        if let dateString = json["time"] as? String {
            self.date = dateFormatter.date(from: dateString)
        }
        if let dateString = json["sunriseTime"] as? String {
            self.sunriseTime = dateFormatter.date(from: dateString)
        }
        if let dateString = json["sunsetTime"] as? String {
            self.sunsetTime = dateFormatter.date(from: dateString)
        }
        
        self.moonPhase = json["moonPhase"] as? Float
        self.precipAccumulation = json["precipAccumulation"] as? Float
        self.tMin = json["temperatureMin"] as? Float
        if let dateString = json["temperatureMinTime"] as? String {
            self.tMinTime = dateFormatter.date(from: dateString)
        }
        
        self.tMax = json["temperatureMax"] as? Float
        if let dateString = json["temperatureMaxTime"] as? String {
            self.tMaxTime = dateFormatter.date(from: dateString)
        }
        
        self.dewPoint = json["dewPoint"] as? Float
        self.humidity = json["humidity"] as? Float
        self.windSpeed = json["windSpeed"] as? Float
        self.windBearing = json["windBearing"] as? Float
        self.pressure = json["pressure"] as? Float
    }
    
    init?(aTime: Date?, aSunriseTime: Date?, aSunsetTime: Date?, aMoonPhase: Float?, aPrecipAccumulation: Float?, aTemperatureMin: Float?, aTemperatureMinTime: Date?, aTemperatureMax: Float?, aTemperatureMaxTime: Date?, aDewPoint: Float?, aHumidity: Float?, aWindSpeed: Float?, aWindBearing: Float?, aPressure: Float?) {
        self.date = aTime
        self.sunriseTime = aSunriseTime
        self.sunsetTime = aSunsetTime
        self.moonPhase = aMoonPhase
        self.precipAccumulation = aPrecipAccumulation
        self.tMin = aTemperatureMin
        self.tMinTime = aTemperatureMinTime
        self.tMax = aTemperatureMax
        self.tMaxTime = aTemperatureMaxTime
        self.dewPoint = aDewPoint
        self.humidity = aHumidity
        self.windSpeed = aWindSpeed
        self.windBearing = aWindBearing
        self.pressure = aPressure
    }
    
    // MARK: NSCoding
    @objc func encode(with aCoder: NSCoder) {
        
        aCoder.encode(self.date, forKey: "time")
        aCoder.encode(self.sunriseTime, forKey: "sunriseTime")
        aCoder.encode(self.sunsetTime, forKey: "sunsetTime")
        aCoder.encode(self.moonPhase, forKey: "moonPhase")
        aCoder.encode(self.precipAccumulation, forKey: "precipAccumulation")
        aCoder.encode(self.tMin, forKey: "temperatureMin")
        aCoder.encode(self.tMinTime, forKey: "temperatureMinTime")
        aCoder.encode(self.tMax, forKey: "temperatureMax")
        aCoder.encode(self.tMaxTime, forKey: "temperatureMaxTime")
        aCoder.encode(self.dewPoint, forKey: "dewPoint")
        aCoder.encode(self.humidity, forKey: "humidity")
        aCoder.encode(self.windSpeed, forKey: "windSpeed")
        aCoder.encode(self.windBearing, forKey: "windBearing")
        aCoder.encode(self.pressure, forKey: "pressure")
        
    }
    
    @objc required convenience init?(coder aDecoder: NSCoder) {
        let time = aDecoder.decodeObject(forKey: "time") as? Date
        let sunriseTime = aDecoder.decodeObject(forKey: "sunriseTime") as? Date
        let sunsetTime = aDecoder.decodeObject(forKey: "sunsetTime") as? Date
        let moonPhase = aDecoder.decodeObject(forKey: "moonPhase") as? Float
        let precipAccumulation = aDecoder.decodeObject(forKey: "precipAccumulation") as? Float
        let temperatureMin = aDecoder.decodeObject(forKey: "temperatureMin") as? Float
        let temperatureMinTime = aDecoder.decodeObject(forKey: "temperatureMinTime") as? Date
        let temperatureMax = aDecoder.decodeObject(forKey: "temperatureMax") as? Float
        let temperatureMaxTime = aDecoder.decodeObject(forKey: "temperatureMaxTime") as? Date
        let dewPoint = aDecoder.decodeObject(forKey: "dewPoint") as? Float
        let humidity = aDecoder.decodeObject(forKey: "humidity") as? Float
        let windSpeed = aDecoder.decodeObject(forKey: "windSpeed") as? Float
        let windBearing = aDecoder.decodeObject(forKey: "windBearing") as? Float
        let pressure = aDecoder.decodeObject(forKey: "pressure") as? Float
        
        // use the existing init function
        self.init(aTime: time, aSunriseTime:sunriseTime, aSunsetTime:sunsetTime, aMoonPhase:moonPhase, aPrecipAccumulation:precipAccumulation, aTemperatureMin:temperatureMin, aTemperatureMinTime:temperatureMinTime, aTemperatureMax:temperatureMax, aTemperatureMaxTime:temperatureMaxTime, aDewPoint:dewPoint, aHumidity:humidity, aWindSpeed:windSpeed, aWindBearing:windBearing, aPressure:pressure)
    }
}

