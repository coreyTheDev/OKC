//
//  Match.swift
//  OKCTest
//
//  Created by Corey Zanotti on 2/1/18.
//  Copyright © 2018 Corey Zanotti. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Match {
    var name:String?
    var location:Location?
    var age:Int?
    var image:Image?
    var percentageMatch:Int?
    
    init(matchJSON: JSON) {
        name = matchJSON["username"].string
        age = matchJSON["age"].int
        
        //grab image from JSON
        let imageJSON = matchJSON["photo"]["full_paths"]
        image = Image(imageJSON: imageJSON)
        
        //grab location from JSON
        let locationJSON = matchJSON["location"]
        location = Location(locationJSON: locationJSON)
        
        //grab match
        let matchValue:Int = matchJSON["match"].int!
        percentageMatch = matchValue/100
    }
}
