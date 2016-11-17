//
//  NOAAPrecip.swift
//  CloudView
//
//  Created by Julian Post on 11/9/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import Foundation

func NOAAInitialParse(json: [String: Any]) -> [Date : Float] {
    
    var dict: [Date : Float]
    
    if let array = json["results"] as? [[String: Any]] {
            
            for i in array {
                if let date = i["date"], let value = i["value"] {
                    let stringOfDate = "\(date)"
                    let formattedDate = DateFunctions.stringToDate(stringOfDate)
                    let stringOfValue = "\(value)"
                    let floatOfValue = Float(stringOfValue)
                    dict[formattedDate] = floatOfValue
                    
                
                }
            }
        
        
    }
    
    return dict
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
