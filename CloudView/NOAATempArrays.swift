//
//  NOAATempArrays.swift
//  CloudView
//
//  Created by Julian Post on 11/9/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import Foundation

class NOAATempArrays {
    
    var currentYearTemperatureMaxArray, currentYearTemperatureMinArray, normalYearTemperatureMaxArray,normalYearTemperatureMinArray, currentMonthTemperatureMaxArray, currentMonthTemperatureMinArray, normalMonthTemperatureMaxArray,normalMonthTemperatureMinArray, currentWeekTemperatureMaxArray, currentWeekTemperatureMinArray, normalWeekTemperatureMaxArray,normalWeekTemperatureMinArray: [Float]
    
    /*var normalYearPrecipCumulative, currentYearPrecipCumulative, normalYearDegreeDayOneCumulative, currentYearDegreeDayOneCumulative, normalYearDegreeDayTwoCumulative, currentYearDegreeDayTwoCumulative, normalYearDegreeDayThreeCumulative, currentYearDegreeDayThreeCumulative: [Float]*/
    
    init(fromCurrentYearTMax currentYearTemperatureMaxDict: [Date : Float], fromNormalYearTMax normalYearTemperatureMaxDict: [Date : Float], fromCurrentYearTemperatureMin currentYearTemperatureMinDict: [Date : Float], fromNormalYearTemperatureMin normalYearTemperatureMinDict: [Date : Float]) {
        
        currentYearTemperatureMaxArray = TransformArray.toSimple(currentYearTemperatureMaxDict)
        currentMonthTemperatureMaxArray = TransformArray.toNormalMonth(currentYearTemperatureMaxDict)
        currentWeekTemperatureMaxArray = TransformArray.toNormalWeek(currentYearTemperatureMaxDict)
        
        normalYearTemperatureMaxArray = TransformArray.toSimple(normalYearTemperatureMaxDict)
        normalMonthTemperatureMaxArray = TransformArray.toNormalMonth(normalYearTemperatureMaxDict)
        normalWeekTemperatureMaxArray = TransformArray.toNormalWeek(normalYearTemperatureMaxDict)
        
        currentYearTemperatureMinArray = TransformArray.toSimple(currentYearTemperatureMinDict)
        currentMonthTemperatureMinArray = TransformArray.toNormalMonth(currentYearTemperatureMinDict)
        currentWeekTemperatureMinArray = TransformArray.toNormalWeek(currentYearTemperatureMinDict)
        
        normalYearTemperatureMinArray = TransformArray.toSimple(normalYearTemperatureMinDict)
        normalMonthTemperatureMinArray = TransformArray.toNormalMonth(normalYearTemperatureMinDict)
        normalWeekTemperatureMinArray = TransformArray.toNormalWeek(normalYearTemperatureMinDict)
    }
}
