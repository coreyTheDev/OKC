//
//  OKMatchSearchCellViewModel.swift
//  OKCTest
//
//  Created by Corey Zanotti on 8/4/17.
//  Copyright © 2017 Corey Zanotti. All rights reserved.
//

import Foundation

fileprivate let dotChar = "\u{2022}"

struct OKMatchSearchCellViewModel {
    let usernameString: String
    let ageAndLocationString: String
    let percentageString: String
    let profileImageURL: URL?
    
    init(with match: OKMatch) {
        usernameString = match.name
        ageAndLocationString = "\(match.age) \(dotChar) \(match.location.cityName), \(match.location.countryCode)"
        percentageString = "\(match.percentageMatch / 1000)% Match"
        profileImageURL = URL(string: match.image.mediumURL)
    }
}
