//
//  SettingsDataArrays.swift
//  NOAA
//
//  Created by Julian Post on 10/16/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import Foundation

struct SettingsDataArrays {
    
    var stationsArray: [String:String]
    var stationFile: Any
    var extent: String
    var currentStation: String
    var minTempOne, maxTempOne, minTempTwo, maxTempTwo, minTempThree, maxTempThree: Int
    var latitude, longitude, bottomLeftLat, bottomLeftLon, topRightLat, topRightLon: String
    
    init(stationsArray: [String:String], stationFile: Any, extent : String, currentStation: String, minTempOne: Int, maxTempOne: Int, minTempTwo: Int, maxTempTwo: Int, minTempThree: Int, maxTempThree: Int, latitude: String, longitude: String, bottomLeftLat: String, bottomLeftLon: String, topRightLat: String, topRightLon: String) {
        
        
        self.stationsArray = [:]
        self.stationFile = ""
        self.extent = ""
        self.currentStation = "GHCND:USW00014742"
        self.minTempOne = 52
        self.maxTempOne = 86
        self.minTempTwo = 32
        self.maxTempTwo = 86
        self.minTempThree = 46
        self.maxTempThree = 90
        self.latitude = ""
        self.longitude = ""
        self.bottomLeftLat = ""
        self.bottomLeftLon = ""
        self.topRightLat = ""
        self.topRightLon = ""
        
    }
}

var mainSettingsData = SettingsDataArrays(stationsArray: [:], stationFile: "", extent: "", currentStation: "", minTempOne: 0, maxTempOne: 0, minTempTwo: 0, maxTempTwo: 0, minTempThree: 0, maxTempThree: 0, latitude: "", longitude: "", bottomLeftLat: "", bottomLeftLon: "", topRightLat: "", topRightLon: "")
