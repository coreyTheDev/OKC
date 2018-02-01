//
//  Location.swift
//  OKCTest
//
//  Created by Corey Zanotti on 2/1/18.
//  Copyright © 2018 Corey Zanotti. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Location{
    var countryName:String?
    var countryCode:String?
    var cityName:String?
    var stateName:String?
    var stateCode:String?
    
    init(locationJSON: JSON) {
        countryName = locationJSON["country_name"].string
        countryCode = locationJSON["country_code"].string
        cityName = locationJSON["city_name"].string
        stateName = locationJSON["state_name"].string
        stateCode = locationJSON["state_code"].string
    }
}
