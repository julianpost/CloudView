//
//  PrecipWeekView.swift
//  CloudView
//
//  Created by Julian Post on 11/27/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import Foundation
import UIKit

public class PrecipWeekView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func draw(_ frame: CGRect) {
        let h = frame.height
        let w = frame.width
        let color:UIColor = UIColor.yellow
        
        let drect = CGRect(x: (w * 0.25), y: (h * 0.25), width: (w * 0.1), height: (h * 0.5))
        let bpath:UIBezierPath = UIBezierPath(rect: drect)
        
        color.set()
        bpath.stroke()
        
        print("it ran")
        NSLog("drawRect has updated the view")
    }
}
