//
//  UpdateView.swift
//  NOAA
//
//  Created by Julian Post on 8/4/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import UIKit

class UpdateView {
    
    //Weekly sample data
    //var arr:[Float] = mainWeatherData.lastYearTemperatureMaxArray
    

    
    static func drawChart(_ view: UIView, current: [Float], normal: [Float]) {
        
        let layerOne = CAShapeLayer()
        let layerTwo = CAShapeLayer()
        
        let width = view.frame.width
        let height = view.frame.height
        
        //set up background clipping area
   /*     let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: UIRectCorner.AllCorners,
                                cornerRadii: CGSize(width: 8.0, height: 8.0))
        path.addClip() */
        
        //2 - get the current context
    //    let context = UIGraphicsGetCurrentContext()
       // let colors = [startColor.CGColor, endColor.CGColor]
        
        //3 - set up the color space
     //   let colorSpace = CGColorSpaceCreateDeviceRGB()
        

 
 
        //calculate the x point
        
        let margin:CGFloat = 20.0
        let columnXPoint = { (column:Int) -> CGFloat in
            //Calculate gap between points
            let spacer = (width - margin*2 - 4) /
                CGFloat((normal.count - 1))
            var x:CGFloat = CGFloat(column) * spacer
            x += margin + 2
            return x
            
        }
        
        // calculate the y point
        
        let topBorder:CGFloat = 60
        let bottomBorder:CGFloat = 50
        let graphHeight = height - topBorder - bottomBorder
        let maxValue = normal.max()!
        
        let columnYPoint = { (graphPoint:Float) -> CGFloat in
            var y:CGFloat = CGFloat(graphPoint) /
                CGFloat(maxValue) * graphHeight
            y = graphHeight + topBorder - y // Flip the graph
            return y
        }
        // draw the line graph
        
       // UIColor.blackColor().setFill()
       // UIColor.blackColor().setStroke()
        
        //set up the points line
        let graphPath = UIBezierPath()
        let graphPathTwo = UIBezierPath()
        
        
        
        
        
        
        //go to start of line
        graphPath.move(to: CGPoint(x:columnXPoint(0),
            y:columnYPoint(current[0])))
        
        graphPathTwo.move(to: CGPoint(x:columnXPoint(0),
            y:columnYPoint(normal[0])))
        
        //add points for each item in the arr array
        //at the correct (x, y) for the point
        for i in 1..<current.count {
            let nextPoint = CGPoint(x:columnXPoint(i),
                                    y:columnYPoint(current[i]))
            
            graphPath.addLine(to: nextPoint)
        }
        
        for i in 1..<normal.count {
            
            let nextPointTwo = CGPoint(x:columnXPoint(i),
                                       y:columnYPoint(normal[i]))
            
            graphPathTwo.addLine(to: nextPointTwo)
        }
        
      //  graphPath.lineWidth = 2.0
      //  graphPathTwo.lineWidth = 2.0
      //  graphPath.stroke()
      //  graphPathTwo.stroke()
        
        
        //layerOne.position = CGPoint(x:columnXPoint(0),
          //                       y:columnYPoint(mainWeatherData.currentYearTemperatureMaxArray[0]))
        //layerTwo.position = CGPoint(x:columnXPoint(0),
          //                       y:columnYPoint(mainWeatherData.currentYearTemperatureMaxArray[0]))
        
        layerOne.path = graphPath.cgPath
        layerTwo.path = graphPathTwo.cgPath

        layerOne.lineWidth = 2.0
        layerTwo.lineWidth = 2.0
        
        layerOne.strokeColor = UIColor.black.cgColor
        layerTwo.strokeColor = UIColor.black.cgColor
     
        layerOne.fillColor = nil
        layerTwo.fillColor = nil
        
        view.layer.addSublayer(layerOne)
        view.layer.addSublayer(layerTwo)
        //self.layer.insertSublayer(layerOne, atIndex: 0)
        //self.layer.insertSublayer(layerTwo, atIndex: 0)
    }
    
    static func handlePrecipCompletion(_ viewOne: UIView, viewTwo: UIView, viewThree: UIView) {
        
        //print("checking")
        //print(mainWeatherData.currentPrecipLoaded)
        //print(mainWeatherData.normalPrecipLoaded)
        
        if mainWeatherData.currentPrecipLoaded && mainWeatherData.normalPrecipLoaded {
            
            UpdateView.drawChart(viewOne, current: mainWeatherData.currentWeekPrecipArray, normal: mainWeatherData.normalWeekPrecipArray)
            UpdateView.drawChart(viewTwo, current: mainWeatherData.currentMonthPrecipArray, normal: mainWeatherData.normalMonthPrecipArray)
            UpdateView.drawChart(viewThree, current: mainWeatherData.currentYearPrecipCumulative, normal: mainWeatherData.normalYearPrecipArray)
            
            
        }
    }
    
    static func handleTempCompletion(_ viewOne: UIView, viewTwo: UIView, viewThree: UIView) {
        if mainWeatherData.currentTMAXLoaded && mainWeatherData.normalTMAXLoaded && mainWeatherData.currentTMINLoaded && mainWeatherData.normalTMINLoaded {
            
            mainWeatherData.currentYearDegreeDayOneCumulative = TransformArray.toDegreeDay(mainSettingsData.minTempOne, maxTemp: mainSettingsData.maxTempOne, tMin: mainWeatherData.currentYearTemperatureMinArray, tMax: mainWeatherData.currentYearTemperatureMaxArray)
            
            mainWeatherData.currentYearDegreeDayOneCumulative = TransformArray.toCumulative(mainWeatherData.currentYearDegreeDayOneCumulative)
            
            mainWeatherData.normalYearDegreeDayOneCumulative = TransformArray.toDegreeDay(mainSettingsData.minTempOne, maxTemp: mainSettingsData.maxTempOne, tMin: mainWeatherData.normalYearTemperatureMinArray, tMax: mainWeatherData.normalYearTemperatureMaxArray)
            mainWeatherData.normalYearDegreeDayOneCumulative = TransformArray.toCumulative(mainWeatherData.normalYearDegreeDayOneCumulative)
            
            UpdateView.drawChart(viewOne, current: mainWeatherData.currentYearDegreeDayOneCumulative, normal: mainWeatherData.normalYearDegreeDayOneCumulative)
            
            mainWeatherData.currentYearDegreeDayTwoCumulative = TransformArray.toDegreeDay(mainSettingsData.minTempTwo, maxTemp: mainSettingsData.maxTempTwo, tMin: mainWeatherData.currentYearTemperatureMinArray, tMax: mainWeatherData.currentYearTemperatureMaxArray)
            
            mainWeatherData.currentYearDegreeDayTwoCumulative = TransformArray.toCumulative(mainWeatherData.currentYearDegreeDayTwoCumulative)
            
            mainWeatherData.normalYearDegreeDayTwoCumulative = TransformArray.toDegreeDay(mainSettingsData.minTempTwo, maxTemp: mainSettingsData.maxTempTwo, tMin: mainWeatherData.normalYearTemperatureMinArray, tMax: mainWeatherData.normalYearTemperatureMaxArray)
            mainWeatherData.normalYearDegreeDayTwoCumulative = TransformArray.toCumulative(mainWeatherData.normalYearDegreeDayTwoCumulative)
            
            UpdateView.drawChart(viewTwo, current: mainWeatherData.currentYearDegreeDayTwoCumulative, normal: mainWeatherData.normalYearDegreeDayTwoCumulative)
            
            mainWeatherData.currentYearDegreeDayThreeCumulative = TransformArray.toDegreeDay(mainSettingsData.minTempThree, maxTemp: mainSettingsData.maxTempThree, tMin: mainWeatherData.currentYearTemperatureMinArray, tMax: mainWeatherData.currentYearTemperatureMaxArray)
            
            mainWeatherData.currentYearDegreeDayThreeCumulative = TransformArray.toCumulative(mainWeatherData.currentYearDegreeDayThreeCumulative)
            
            mainWeatherData.normalYearDegreeDayThreeCumulative = TransformArray.toDegreeDay(mainSettingsData.minTempThree, maxTemp: mainSettingsData.maxTempThree, tMin: mainWeatherData.normalYearTemperatureMinArray, tMax: mainWeatherData.normalYearTemperatureMaxArray)
            mainWeatherData.normalYearDegreeDayThreeCumulative = TransformArray.toCumulative(mainWeatherData.normalYearDegreeDayThreeCumulative)
            
            UpdateView.drawChart(viewThree, current: mainWeatherData.currentYearDegreeDayThreeCumulative, normal: mainWeatherData.normalYearDegreeDayThreeCumulative)
            
           
        }
    }
}
