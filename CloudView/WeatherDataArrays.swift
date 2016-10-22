//
//  WeatherDataArrays.swift
//  NOAA
//
//  Created by Julian Post on 7/30/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//


import Foundation

struct WeatherDataArrays {

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
    
    init(currentYearPrecipArray: [Float], currentYearTemperatureMaxArray: [Float], currentYearTemperatureMinArray: [Float], normalPrecipArray: [Float], normalYearTemperatureMaxArray: [Float],normalYearTemperatureMinArray: [Float], currentMonthPrecipArray: [Float], currentMonthTemperatureMaxArray: [Float], currentMonthTemperatureMinArray: [Float], normalMonthPrecipArray: [Float], normalMonthTemperatureMaxArray: [Float],normalMonthTemperatureMinArray: [Float], currentWeekPrecipArray: [Float], currentWeekTemperatureMaxArray: [Float], currentWeekTemperatureMinArray: [Float], normalWeekPrecipArray: [Float], normalWeekTemperatureMaxArray: [Float],normalWeekTemperatureMinArray: [Float],currentYearPrecipDict: [Date : Float], currentYearTemperatureMaxDict: [Date : Float], currentYearTemperatureMinDict: [Date : Float], normalYearPrecipDict: [Date : Float], normalYearTemperatureMaxDict: [Date : Float], normalYearTemperatureMinDict: [Date : Float], normalYearPrecipCumulative: [Float], currentYearPrecipCumulative: [Float], normalYearDegreeDayCumulative: [Float], currentYearDegreeDayCumulative: [Float], currentPrecipLoaded: Bool, normalPrecipLoaded: Bool, currentTMAXLoaded: Bool, normalTMAXLoaded: Bool, currentTMINLoaded: Bool, normalTMINLoaded: Bool) {
    
    //let today = Date()
    let gregorian: Calendar! = Calendar(identifier: Calendar.Identifier.gregorian)
    
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
        
    }
    
    
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


/*
 
 let today = NSDate()
 let gregorian: NSCalendar! = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
 
 var blankDict:[NSDate : Float] = [:]
 var start = Date.lastYearStartMath(today)
 var end = Date.lastYearEndMath(today)
 var counter: Float = 1
 
 let dateComponents = NSDateComponents()
 dateComponents.day = 1
 end = gregorian.dateByAddingComponents(dateComponents, toDate: end, options: NSCalendarOptions(rawValue: 0))!
 
 repeat {
 
 blankDict[start] = counter
 
 // print(blankDict.count)
 // print(start)
 //print(blankDict[end])
 // print("end: \(end)")
 
 counter += 0.1
 
 // increment the date by 1 day
 let dateComponents = NSDateComponents()
 dateComponents.day = 1
 start = gregorian.dateByAddingComponents(dateComponents, toDate: start, options: NSCalendarOptions(rawValue: 0))!
 
 
 } while start != end
 
 print(blankDict)
 
 let sortedDict = blankDict.sort { $0.0.compare($1.0) == .OrderedAscending }
 
 
 var arr: [Float] = []
 for (_,value) in sortedDict {
 
 arr.append(value)
 
 }
 print(arr)

var precipCalc:[NSDate : Float] = [:]
var startMinusOne = Date.lastYearStartMath(today)


// changes end date to Jan 1 of the next year so loop will complete all 365 values
let endDateComponents = NSDateComponents()
endDateComponents.day = 1
end = gregorian.dateByAddingComponents(endDateComponents, toDate: end, options: NSCalendarOptions(rawValue: 0))!

//changes startMinusOne date so that it can be used to add values cumulatively
let startMinusOneDateComponents = NSDateComponents()
startMinusOneDateComponents.day = -1
startMinusOne = gregorian.dateByAddingComponents(startMinusOneDateComponents, toDate: startMinusOne, options: NSCalendarOptions(rawValue: 0))!

repeat {
    
    precipCalc[start] = mainWeatherData.normalYearPrecipDict[start]! + (mainWeatherData.normalYearPrecipDict[startMinusOne] ?? 0.0)
    
    // print("end: \(precipCalc)")
    
    
    // increment the date by 1 day
    let dateComponents = NSDateComponents()
    dateComponents.day = 1
    start = gregorian.dateByAddingComponents(dateComponents, toDate: start, options: NSCalendarOptions(rawValue: 0))!
    startMinusOne = gregorian.dateByAddingComponents(dateComponents, toDate: startMinusOne, options: NSCalendarOptions(rawValue: 0))!
    
} while start != end
 
 */



