//
//  OKMatchSearchViewModel.swift
//  OKCTest
//
//  Created by Corey Zanotti on 8/7/17.
//  Copyright © 2017 Corey Zanotti. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Kingfisher

fileprivate let kMatchSearchEndpoint = "https://www.okcupid.com/matchSample.json"

class OKMatchSearchViewModel {
    var searchResults: [OKMatchSearchCellViewModel]
    
    init() {
        searchResults = [OKMatchSearchCellViewModel]()
        getMatches()
    }
    
    //MARK: Public
    
    func modelForCell(at indexPath: IndexPath) -> OKMatchSearchCellViewModel {
        return searchResults[indexPath.item]
    }
    
    func numberOfRows() -> Int {
        return searchResults.count
    }
    
    //MARK: Networking
    
    func getMatches(){
        Alamofire.request(kMatchSearchEndpoint).responseJSON { response in
            
            let jsonData = JSON(response.result.value)
            let responseJSONArray = jsonData["data"]
            
            for (_, subJSON): (String, JSON) in responseJSONArray {
                
                if let match = OKMatch(with: subJSON) {
                    self.searchResults.append(OKMatchSearchCellViewModel(with: match))
                }
            }
            
            NotificationCenter.default.post(name: NSNotification.Name(kResultsFetchCompleted), object: nil)
        }
    }
}
