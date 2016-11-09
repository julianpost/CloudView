//
//  NOAATMax.swift
//  CloudView
//
//  Created by Julian Post on 11/9/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import Foundation

class TMax: NSObject, NSCoding{
    var date: Date?
    var value: Float?
    
    required init?(json: [String: Any]) {
        
        let dateFormatter = DSObservations.dateFormatter()
        
        if let dateString = json["date"] as? String {
            self.date = dateFormatter.date(from: dateString)
        }
        
        self.value = json["value"] as? Float
    }
    
    init?(aDate: Date?, aValue: Float?) {
        self.date = aDate
        self.value = aValue
    }
    
    // MARK: NSCoding
    @objc func encode(with aCoder: NSCoder) {
        
        aCoder.encode(self.date, forKey: "date")
        aCoder.encode(self.value, forKey: "value")
        
    }
    
    @objc required convenience init?(coder aDecoder: NSCoder) {
        let date = aDecoder.decodeObject(forKey: "date") as? Date
        let value = aDecoder.decodeObject(forKey: "value") as? Float
        
        // use the existing init function
        self.init(aDate: date, aValue: value)
    }
}
