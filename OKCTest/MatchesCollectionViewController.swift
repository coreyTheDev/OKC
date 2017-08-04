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
import Kingfisher

private let reuseIdentifier = "MatchesCollectionViewCell"
private let margin = 13.0
private let cellAspectRatio = CGFloat(388.0/333.0)



class MatchesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var matchesArray:[OKMatch] = [OKMatch]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView?.register(UINib(nibName:"MatchesCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: reuseIdentifier)
        
        self.title = "Browse"
        let textColorDictionary: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textColorDictionary as? [String : Any]
        
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
        let profileCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MatchesCollectionViewCell
    
        // Configure the cell
        let profileForCell = matchesArray[indexPath.row]
        
        let url = URL(string: profileForCell.image!.largeURL!)
        profileCell.profileImageView.kf.setImage(with: url)
        
        profileCell.usernameLabel.text = profileForCell.name!
        
        let dotChar = "\u{2022}"
        profileCell.locationLabel.text = "\(profileForCell.age!) \(dotChar) \(profileForCell.location!.cityName!), \(profileForCell.location!.countryCode!)"
        profileCell.percentageLabel.text = "\(profileForCell.percentageMatch!)% Match"
        
        return profileCell
    }
    
    //MARK: UICollectionViewFlowLayout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthofCell = (collectionView.frame.size.width - CGFloat(3 * margin))/2
        //determine height of image given width of cell and add constant value for labels
        let heightOfImage = cellAspectRatio * widthofCell
        
        let heightOfCell = heightOfImage + 100.0
        return CGSize(width: widthofCell, height: heightOfCell)
    }

    //MARK: Networking methods
    func getMatches(){
        
        let matchURLString = "https://www.okcupid.com/matchSample.json"
        
        Alamofire.request(matchURLString).responseJSON { response in

            let jsonData = JSON(response.result.value)
            let responseJSONArray = jsonData["data"]
            
            for (_, subJSON): (String, JSON) in responseJSONArray {
                
                if let match = OKMatch(with: subJSON) {
                    self.matchesArray.append(match)
                }
            }
            self.collectionView?.reloadData()
        }
    }
}
