//
//  MatchesCollectionViewController.swift
//  OKCTest
//
//  Created by Corey Zanotti on 10/20/16.
//  Copyright © 2016 Corey Zanotti. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

private let reuseIdentifier = "MatchesCollectionViewCell"
private let margin = 13.0
private let cellAspectRatio = CGFloat(515.0/333.0)

struct Image {
    var originalURL:String?
    var smallURL:String?
    var mediumURL:String?
    var largeURL:String?
}
struct Location{
    var countryName:String?
    var countryCode:String?
    var cityName:String?
    var stateName:String?
    var stateCode:String?
}
struct Match {
    var name:String?
    var location:Location?
    var age:Int?
    var image:Image?
    
}

class MatchesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var matchesArray:[Match] = [Match]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView?.register(UINib(nibName:"MatchesCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: reuseIdentifier)
        
        self.title = "Browse"
        
        self.getMatches()
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.matchesArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }
    
    //MARK: UICollectionViewFlowLayout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthofCell = (collectionView.frame.size.width - CGFloat(3 * margin))/2
        let heightOfCell = cellAspectRatio * widthofCell
        return CGSize(width: widthofCell, height: heightOfCell)
    }

    //MARK: Networking methods
    func getMatches(){
        
        let matchURLString = "https://www.okcupid.com/matchSample.json"
        
        Alamofire.request(matchURLString).responseJSON { response in

            let jsonData = JSON(response.result.value)
            let responseJSONArray = jsonData["data"]
            
            for (_, subJSON): (String, JSON) in responseJSONArray {
                
                //grab image from JSON
                let photoJSON = subJSON["photo"]["full_paths"]
                let profileImage = Image(originalURL: photoJSON["original"].string, smallURL: photoJSON["small"].string, mediumURL: photoJSON["medium"].string, largeURL: photoJSON["large"].string)
                
                //grab location from JSON
                let locationJSON = subJSON["location"]
                let location = Location(countryName: locationJSON["country_name"].string, countryCode: locationJSON["country_code"].string, cityName: locationJSON["city_name"].string, stateName: locationJSON["state_name"].string, stateCode: locationJSON["state_code"].string)
                
                //create match object 
                let match = Match(name: subJSON["username"].string, location: location, age: subJSON["age"].int, image: profileImage)
             
                self.matchesArray.append(match)
            }
            self.collectionView?.reloadData()
        }
    }
}
