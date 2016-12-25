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
    
    init(fromCurrentYearPrecip currentYearPrecipDict: [Date : Float], fromNormalYearPrecip normalYearPrecipDict: [Date : Float]) {
        
        currentYearPrecipArray = TransformArray.toSimple(currentYearPrecipDict)
        currentYearPrecipCumulative = TransformArray.toCumulative(currentYearPrecipArray)
        currentMonthPrecipArray = TransformArray.toCurrentMonth(currentYearPrecipDict)
        currentWeekPrecipArray = TransformArray.toCurrentWeek(currentYearPrecipDict)
        
        normalYearPrecipArray = TransformArray.toSimple(normalYearPrecipDict)
        normalYearPrecipCumulative = TransformArray.toCumulative(normalYearPrecipArray)
        normalMonthPrecipArray = TransformArray.toNormalMonth(normalYearPrecipDict)
        normalWeekPrecipArray = TransformArray.toNormalWeek(normalYearPrecipDict)
    }
}
