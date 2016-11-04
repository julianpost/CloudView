//
//  DSObservations.swift
//  CloudView
//
//  Created by Julian Post on 11/2/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import Foundation

class DSObservations: NSObject, NSCoding {
    var daily: [DSDaily]?
    
    static let sharedDateFormatter = dateFormatter()
    
    class func dateFormatter() -> DateFormatter {
        let aDateFormatter = DateFormatter()
        aDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        aDateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        aDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return aDateFormatter
    }
    
    required override init() {
    }
    
    required init?(json: [String: Any]) {
        
        // files
        self.daily = [DSDaily]()
        if let dailysJSON = json["daily"] as? [String: [String: Any]] {
            for (_, dailyJSON) in dailysJSON {
                if let newDaily = DSDaily(json: dailyJSON) {
                    self.daily?.append(newDaily)
                }
            }
        }
        
    }
    // MARK: NSCoding
    @objc func encode(with aCoder: NSCoder) {
        aCoder.encode(self.daily, forKey: "daily")
        }
    
    
    @objc required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        if let dailys = aDecoder.decodeObject(forKey: "daily") as? [DSDaily] {
            self.daily = dailys
        }
    }

}
