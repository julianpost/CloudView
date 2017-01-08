//
//  NOAAPrecipArrays.swift
//  CloudView
//
//  Created by Julian Post on 11/9/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import Foundation

class NOAAPrecipArrays {

    var currentYearPrecipArray, normalYearPrecipArray, currentMonthPrecipArray, normalMonthPrecipArray, currentWeekPrecipArray, normalWeekPrecipArray, currentYearPrecipCumulative, normalYearPrecipCumulative: [Float]
    
    var  weekTotalPrecip, fortyEightHourPrecip, monthTotalPrecip, avgMonthByNow, seasonTotalPrecip, avgSeasonByNow: String
    
    init(fromCurrentYearPrecip currentYearPrecipDict: [Date : Float], fromNormalYearPrecip normalYearPrecipDict: [Date : Float]) {
        
        currentYearPrecipArray = TransformArray.toSimple(currentYearPrecipDict)
        currentYearPrecipCumulative = TransformArray.toCumulative(currentYearPrecipArray)
        currentMonthPrecipArray = TransformArray.toCurrentMonth(currentYearPrecipDict)
        currentWeekPrecipArray = TransformArray.toCurrentWeek(currentYearPrecipDict)
        
        normalYearPrecipArray = TransformArray.toSimple(normalYearPrecipDict)
        normalYearPrecipCumulative = TransformArray.toCumulative(normalYearPrecipArray)
        normalMonthPrecipArray = TransformArray.toNormalMonth(normalYearPrecipDict)
        normalWeekPrecipArray = TransformArray.toNormalWeek(normalYearPrecipDict)
        
        weekTotalPrecip = String(currentWeekPrecipArray.reduce(0, +)) + " inches"
        fortyEightHourPrecip = String(currentWeekPrecipArray[5] + currentWeekPrecipArray[6])  + " inches"
        
        monthTotalPrecip = String(currentMonthPrecipArray.reduce(0, +)) + " inches"
        avgMonthByNow = "TBC"
        
        seasonTotalPrecip = String(currentYearPrecipArray.reduce(0, +)) + " inches"
        avgSeasonByNow = "TBC"
    }
}

var mainPrecipArray: NOAAPrecipArrays?
