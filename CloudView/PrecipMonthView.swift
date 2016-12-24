//
//  PrecipMonthView.swift
//  CloudView
//
//  Created by Julian Post on 12/14/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import UIKit
//import PlaygroundSupport

class MakeMonthBarView {
    
    
    static func drawMonthBars(_ mainView: UIView, observations: NOAAPrecipArrays) {
        
        let dateComponents = DateComponents()
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        
        var barFrames = [CGRect()]
        var barViews = [UIView()]

        //let bigFrameSize = CGRect(x: 100, y: 100, width: 400, height: 400)
        //let barFrameSize = CGRect(x: 100, y: 100, width: 30, height: 300)
        //let bigFrame = UIView(frame: bigFrameSize)
        //let barFrame = UIView(frame: barFrameSize)

        //bigFrame.frame = bigFrameSize

        //mainView.backgroundColor = UIColor.orange
        //barFrame.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 0)

        //PlaygroundPage.current.needsIndefiniteExecution = true
        //PlaygroundPage.current.liveView = bigFrame

        func makeRectangles() {
    
            for i in 0...numDays {
                
                let value: Float = observations.currentMonthPrecipArray[i]
                let maxValue: Float = observations.currentMonthPrecipArray.max()!
                let barHeight = Int(value * 300.0/maxValue)
                let frame = CGRect(x: 10*i, y: 300-barHeight, width: 6, height: barHeight)
        
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

        print("it ran")
        NSLog("drawRect has updated the view")

        //bigFrame.addSubview(barViews[0])

        makeRectangles()
        makeSubViews()
        addSubViews()
    }
}
