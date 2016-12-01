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
        currentWeekPrecipArray = /*TransformArray.toCurrentWeek(currentYearPrecipDict)*/ [0.1, 0.2, 0.0, 0.0, 1.1, 0.5, 0]
        
        normalYearPrecipArray = TransformArray.toSimple(normalYearPrecipDict)
        normalYearPrecipCumulative = TransformArray.toCumulative(normalYearPrecipArray)
        normalMonthPrecipArray = TransformArray.toNormalMonth(normalYearPrecipDict)
        normalWeekPrecipArray = TransformArray.toNormalWeek(normalYearPrecipDict)
    }
}
