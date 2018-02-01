//
//  Image.swift
//  OKCTest
//
//  Created by Corey Zanotti on 2/1/18.
//  Copyright © 2018 Corey Zanotti. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Image {
    
    var originalURL:String?
    var smallURL:String?
    var mediumURL:String?
    var largeURL:String?
    
    init(imageJSON: JSON) {
        originalURL = imageJSON["original"].string
        smallURL = imageJSON["small"].string
        mediumURL = imageJSON["medium"].string
        largeURL = imageJSON["large"].string
    }
}
