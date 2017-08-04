//
//  OKMatch.swift
//  OKCTest
//
//  Created by Corey Zanotti on 8/4/17.
//  Copyright © 2017 Corey Zanotti. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct OKImage {
    let originalURL:String
    let smallURL:String
    let mediumURL:String
    let largeURL:String
    
    init?(with photoPathsJSON: JSON) {
        guard
            let originalURL = photoPathsJSON["original"].string,
            let smallURL = photoPathsJSON["small"].string,
            let mediumURL = photoPathsJSON["medium"].string,
            let largeURL = photoPathsJSON["large"].string
            else {
                return nil
        }
        
        self.originalURL = originalURL
        self.smallURL = smallURL
        self.mediumURL = mediumURL
        self.largeURL = largeURL
    }
}

struct OKLocation{
    let countryName:String
    let countryCode:String
    let cityName:String
    let stateName:String
    let stateCode:String
    
    init?(with locationJSON: JSON) {
        guard
            let countryName = locationJSON["country_name"].string,
            let countryCode = locationJSON["country_code"].string,
            let cityName = locationJSON["city_name"].string,
            let stateName = locationJSON["state_name"].string,
            let stateCode = locationJSON["state_code"].string else {
                return nil
        }
        
        self.countryName = countryName
        self.countryCode = countryCode
        self.cityName = cityName
        self.stateName = stateName
        self.stateCode = stateCode
    }
}

struct OKMatch {
    let name:String
    let location:OKLocation
    let age:Int
    let image:OKImage
    let percentageMatch:Int
    
    init?(with matchJSON: JSON) {
        guard
            let name = matchJSON["username"].string,
            let age = matchJSON["age"].int,
            let matchValue = matchJSON["match"].int,
            let location = OKLocation(with: matchJSON["location"]),
            let imagePaths = OKImage(with: matchJSON["photo"]["full_paths"])
            else {
                return nil
        }
        
        self.name = name
        self.age = age
        self.percentageMatch = matchValue
        self.location = location
        self.image = imagePaths
    }
}
