//
//  NOAADaily.swift
//  CloudView
//
//  Created by Julian Post on 11/9/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import Foundation

class NOAADaily: NSObject, NSCoding{
    var currentYearPrecipArray, currentYearTemperatureMaxArray, currentYearTemperatureMinArray, normalYearPrecipArray, normalYearTemperatureMaxArray,normalYearTemperatureMinArray: [Float]
    
    var currentMonthPrecipArray, currentMonthTemperatureMaxArray, currentMonthTemperatureMinArray, normalMonthPrecipArray, normalMonthTemperatureMaxArray,normalMonthTemperatureMinArray: [Float]
    
    var currentWeekPrecipArray, currentWeekTemperatureMaxArray, currentWeekTemperatureMinArray, normalWeekPrecipArray, normalWeekTemperatureMaxArray,normalWeekTemperatureMinArray: [Float]
    
    var normalYearPrecipCumulative, currentYearPrecipCumulative, normalYearDegreeDayOneCumulative, currentYearDegreeDayOneCumulative, normalYearDegreeDayTwoCumulative, currentYearDegreeDayTwoCumulative, normalYearDegreeDayThreeCumulative, currentYearDegreeDayThreeCumulative: [Float]
    
    var currentYearPrecipDict, currentYearTemperatureMaxDict, currentYearTemperatureMinDict, normalYearPrecipDict, normalYearTemperatureMaxDict, normalYearTemperatureMinDict: [Date : Float]
    
    var currentPrecipLoaded = false
    var normalPrecipLoaded = false
    var currentTMAXLoaded = false
    var normalTMAXLoaded = false
    var currentTMINLoaded = false
    var normalTMINLoaded = false
    
    required override init() {
    }
   
    
    required init(json: [String: Any]) {
        if let array = json["results"] as? [[String: Any]] {
        
        for i in array {
            if let date = i["date"], let value = i["value"] {
                let stringOfDate = "\(date)"
                let formattedDate = DateFunctions.stringToDate(stringOfDate)
                let stringOfValue = "\(value)"
                let floatOfValue = Float(stringOfValue)
                currentYearPrecipDict[formattedDate] = floatOfValue
                
                }
            }
        }
        
        //let today = Date()
        /*let gregorian: Calendar! = Calendar(identifier: Calendar.Identifier.gregorian)
        
        var blankDict:[Date : Float] = [:]
        var start = dateFor.normalYearStart
        var end = dateFor.normalYearEnd
        var counter: Float = 1
        
        var dateComponents = DateComponents()
        dateComponents.day = 1
        end = gregorian.date(byAdding: dateComponents, to: end)!
        
        repeat {
            
            blankDict[start] = counter
            
            counter += 0.1
            
            // increment the date by 1 day
            var dateComponents = DateComponents()
            dateComponents.day = 1
            start = gregorian.date(byAdding: dateComponents, to: start)!
            
            
        } while start != end
        
        let sortedDict = blankDict.sorted { $0.0.compare($1.0) == .orderedAscending }
        
        var arrYear: [Float] = []
        for (_,value) in sortedDict {
            
            arrYear.append(value)
            
        }
        
        var arrMonth: [Float] = []
        
        for i in 0...30 {
            
            arrMonth.insert(2, at: i)
            
        }
        
        var arrWeek: [Float] = []
        
        for i in 0...6 {
            
            arrWeek.insert(2, at: i)
            
        }*/
        
        
        //var precipCalc:[Date : Float] = [:]
        var startMinusOne = dateFor.normalYearStart
        
        
        // changes end date to Jan 1 of the next year so loop will complete all 365 values
        var endDateComponents = DateComponents()
        endDateComponents.day = 1
        end = gregorian.date(byAdding: endDateComponents, to: end)!
        
        //changes startMinusOne date so that it can be used to add values cumulatively
        var startMinusOneDateComponents = DateComponents()
        startMinusOneDateComponents.day = -1
        startMinusOne = gregorian.date(byAdding: startMinusOneDateComponents, to: startMinusOne)!
        
        self.currentYearPrecipDict = blankDict
        self.currentYearTemperatureMaxDict = blankDict
        self.currentYearTemperatureMinDict = blankDict
        self.normalYearPrecipDict = blankDict
        self.normalYearTemperatureMaxDict = blankDict
        self.normalYearTemperatureMinDict = blankDict
        
        self.currentYearPrecipArray = arrYear
        self.currentYearTemperatureMaxArray = arrYear
        self.currentYearTemperatureMinArray = arrYear
        self.normalYearPrecipArray = arrYear
        self.normalYearTemperatureMaxArray = arrYear
        self.normalYearTemperatureMinArray = arrYear
        
        self.currentMonthPrecipArray = [2,5,6,7,8,9,5,6,7,5,4,3,2,3,4,7,8,9,4,3,2,1,5,6,7,6,6,6,4,3]
        self.currentMonthTemperatureMaxArray = arrMonth
        self.currentMonthTemperatureMinArray = arrMonth
        self.normalMonthPrecipArray = [1,2,3,4,5,6,5,4,5,6,7,8,9,8,7,6,5,4,3,4,5,6,7,8,9,4,7,6,2,9]
        self.normalMonthTemperatureMaxArray = arrMonth
        self.normalMonthTemperatureMinArray = arrMonth
        
        self.currentWeekPrecipArray = [2,5,6,7,8,9,5]
        self.currentWeekTemperatureMaxArray = arrWeek
        self.currentWeekTemperatureMinArray = arrWeek
        self.normalWeekPrecipArray = [1,2,3,4,5,6,5]
        self.normalWeekTemperatureMaxArray = arrWeek
        self.normalWeekTemperatureMinArray = arrWeek
        
        self.normalYearPrecipCumulative = arrYear
        self.currentYearPrecipCumulative = arrYear
        self.normalYearDegreeDayOneCumulative = arrYear
        self.currentYearDegreeDayOneCumulative = arrYear
        self.normalYearDegreeDayTwoCumulative = arrYear
        self.currentYearDegreeDayTwoCumulative = arrYear
        self.normalYearDegreeDayThreeCumulative = arrYear
        self.currentYearDegreeDayThreeCumulative = arrYear
        
        self.currentPrecipLoaded = false
        self.normalPrecipLoaded = false
        self.currentTMAXLoaded = false
        self.normalTMAXLoaded = false
        self.currentTMINLoaded = false
        self.normalTMINLoaded = false
        
    }
    
}

var mainWeatherData = WeatherDataArrays(currentYearPrecipArray: [], currentYearTemperatureMaxArray: [], currentYearTemperatureMinArray: [], normalPrecipArray: [], normalYearTemperatureMaxArray: [],normalYearTemperatureMinArray: [], currentMonthPrecipArray: [], currentMonthTemperatureMaxArray: [], currentMonthTemperatureMinArray: [], normalMonthPrecipArray: [], normalMonthTemperatureMaxArray: [],normalMonthTemperatureMinArray: [], currentWeekPrecipArray: [], currentWeekTemperatureMaxArray: [], currentWeekTemperatureMinArray: [], normalWeekPrecipArray: [], normalWeekTemperatureMaxArray: [],normalWeekTemperatureMinArray: [],currentYearPrecipDict: [:], currentYearTemperatureMaxDict: [:], currentYearTemperatureMinDict: [:], normalYearPrecipDict: [:], normalYearTemperatureMaxDict: [:], normalYearTemperatureMinDict: [:], normalYearPrecipCumulative: [], currentYearPrecipCumulative: [], normalYearDegreeDayCumulative: [], currentYearDegreeDayCumulative: [], currentPrecipLoaded: false, normalPrecipLoaded: false, currentTMAXLoaded: false, normalTMAXLoaded: false, currentTMINLoaded: false, normalTMINLoaded: false)

    
}

/*class NOAADaily: NSObject, NSCoding{
    var precip: Precip?
    var tMax: TMax?
    var tMin: TMin?
    
    required init?(json: [String: Any]) {
        
        self.precip = json["value"] as? Precip
        self.tMax = json["value"] as? TMax
        self.tMin = json["value"] as? TMin
    }
    
    init?(aPrecip: Precip?, aTMax: TMax?, aTMin: TMin?) {
        self.precip = aPrecip
        self.tMax = aTMax
        self.tMin = aTMin
    }
    
    // MARK: NSCoding
    @objc func encode(with aCoder: NSCoder) {
        
        aCoder.encode(self.precip, forKey: "value")
        aCoder.encode(self.tMax, forKey: "value")
        aCoder.encode(self.tMin, forKey: "value")
        
    }
    
    @objc required convenience init?(coder aDecoder: NSCoder) {
        let precip = aDecoder.decodeObject(forKey: "value") as? Precip
        let tMax = aDecoder.decodeObject(forKey: "value") as? TMax
        let tMin = aDecoder.decodeObject(forKey: "value") as? TMin
        
        // use the existing init function
        self.init(aPrecip: precip, aTMax: tMax, aTMin: tMin)
    }
}*/
