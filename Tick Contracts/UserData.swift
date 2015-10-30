//
//  File.swift
//  Tick
//
//  Created by Martin Schinz on 30/10/2015.
//  Copyright © 2015 pebble{code}. All rights reserved.
//

import Foundation
import CoreLocation


struct UserData {
    let timeStamp : NSDate
    let type : String
    let location : CLLocationCoordinate2D
    
    init(type: String, location: CLLocationCoordinate2D) {
        timeStamp = NSDate()
        self.type = type
        self.location = location
    }
}