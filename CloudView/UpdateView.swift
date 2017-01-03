//
//  UpdateView.swift
//  NOAA
//
//  Created by Julian Post on 8/4/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import UIKit

class UpdateView {
    
    static func drawWeekBars(_ mainView: UIView, observations: NOAAPrecipArrays) {
        
        var barFrames = [CGRect()]
        var barViews = [UIView()]
        
        mainView.backgroundColor = UIColor.lightGray
        mainView.layer.cornerRadius = 6.0
        mainView.layer.masksToBounds = true
        mainView.layer.borderWidth = 0.0
       // mainView.layer.borderColor = UIColor.white.cgColor
        
        func makeRectangles() {
            
            for i in 0...6 {
                
                var value: Float = observations.currentWeekPrecipArray[i]
               
                if value == 0 {
                    value = 0.005
                }
                
                let maxValue: Float
                
                if observations.currentMonthPrecipArray.max()! == 0 {
                    maxValue = 1
                }
                    
                else {
                    maxValue = observations.currentMonthPrecipArray.max()!
                }
                
                let barHeight = Int(value * 300.0/maxValue)
                let frame = CGRect(x: 26 + 42*i, y: 300-barHeight, width: 35, height: barHeight)
                
                barFrames.insert(frame, at: i)
            }
        }
        
        func makeSubViews() {
            
            for i in 0...7 {
                let view = UIView(frame: barFrames[i])
                view.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
                
                barViews.insert(view, at: i)
            }
        }
        
        
        func addSubViews() {
            
            for i in 0...7 {
                
                mainView.addSubview(barViews[i])
            }
        }
        
        makeRectangles()
        makeSubViews()
        addSubViews()
    }

    
    static func drawMonthBars(_ mainView: UIView, observations: NOAAPrecipArrays) {
        
        let dateComponents = DateComponents()
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count - 1
        
        var barFrames = [CGRect()]
        var barViews = [UIView()]
        
        mainView.backgroundColor = UIColor.lightGray
        mainView.layer.cornerRadius = 6.0
        mainView.layer.masksToBounds = true
        mainView.layer.borderWidth = 0.0
       // mainView.layer.borderColor = UIColor.white.cgColor
        
        func makeRectangles() {
            
            for i in 0...numDays {
                
                var value: Float = observations.currentMonthPrecipArray[i]
                
                if value == 0 {
                    value = 0.005
                }
                
                let maxValue: Float
                
                if observations.currentMonthPrecipArray.max()! == 0 {
                    maxValue = 1
                }
                    
                else {
                    maxValue = observations.currentMonthPrecipArray.max()!
                }
                
                let barHeight = Int(value * 300.0/maxValue)
                let frame = CGRect(x: 12 + 10*i, y: 300-barHeight, width: 6, height: barHeight)
                
                barFrames.insert(frame, at: i)
            }
        }
        
        func makeSubViews() {
            
            for i in 0...numDays {
                let view = UIView(frame: barFrames[i])
                view.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
                
                barViews.insert(view, at: i)
            }
        }
        
        
        func addSubViews() {
            
            for i in 0...numDays {
                
                mainView.addSubview(barViews[i])
            }
        }
        
        makeRectangles()
        makeSubViews()
        addSubViews()
    }
    
    static func drawChart(_ view: UIView, current: [Float], normal: [Float]) {
        
        let layerOne = CAShapeLayer()
        let layerTwo = CAShapeLayer()
        
        let width = view.frame.width
        let height = view.frame.height
        
        view.backgroundColor = UIColor.lightGray
        view.layer.cornerRadius = 6.0
        view.layer.masksToBounds = true
        view.layer.borderWidth = 0.0
        //view.layer.borderColor = UIColor.white.cgColor
        
      
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
        
        layerOne.path = graphPath.cgPath
        layerTwo.path = graphPathTwo.cgPath

        layerOne.lineWidth = 2.0
        layerTwo.lineWidth = 2.0
        
        layerOne.strokeColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1).cgColor

        layerTwo.strokeColor = UIColor.black.cgColor
     
        layerOne.fillColor = nil
        layerTwo.fillColor = nil
        
        view.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        
        view.layer.addSublayer(layerTwo)
        view.layer.addSublayer(layerOne)
    }
    
    static func handlePrecipCompletion(_ viewOne: UIView, viewTwo: UIView, viewThree: UIView, precip: NOAAPrecipArrays) {
            
            //UpdateView.drawChart(viewOne, current: precip.currentWeekPrecipArray, normal: precip.normalWeekPrecipArray)
            //UpdateView.drawChart(viewTwo, current: precip.currentMonthPrecipArray, normal: precip.normalMonthPrecipArray)
            UpdateView.drawChart(viewThree, current: precip.currentYearPrecipCumulative, normal: precip.normalYearPrecipArray)
    }
    
    static func handleTempCompletion(_ viewOne: UIView, temp: NOAATempArrays) {
        
            UpdateView.drawChart(viewOne, current: temp.currentYearDegreeDayOneCumulative, normal: temp.normalYearDegreeDayOneCumulative)
            //UpdateView.drawChart(viewTwo, current: temp.currentYearDegreeDayTwoCumulative, normal: temp.normalYearDegreeDayTwoCumulative)
            //UpdateView.drawChart(viewThree, current: temp.currentYearDegreeDayThreeCumulative, normal: temp.normalYearDegreeDayThreeCumulative)
    }
}
