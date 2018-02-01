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

class MatchesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var matchesArray:[Match] = [Match]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupCollectionView()
        self.getMatches()
    }

    // MARK: - Setup
    
    private func setupNavigationBar() {
        self.title = "Browse"
        let textColorDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textColorDictionary
    }
    
    private func setupCollectionView() {
        collectionView?.register(UINib(nibName:"MatchesCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.matchesArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let profileCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MatchesCollectionViewCell
    
        // Configure the cell
        let match = matchesArray[indexPath.row]
        profileCell.configure(with: match)
        
        return profileCell
    }
    
    //MARK: - UICollectionViewFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return calculateCellSize()
    }

    //MARK: - Networking methods
    
    func getMatches(){
        
        let matchURLString = "https://www.okcupid.com/matchSample.json"
        
        Alamofire.request(matchURLString).responseJSON { response in
            let jsonData = JSON(response.result.value)
            let responseJSONArray = jsonData["data"]
            
            for (_, subJSON): (String, JSON) in responseJSONArray {
                let match = Match(matchJSON: subJSON)
                self.matchesArray.append(match)
            }
            self.collectionView?.reloadData()
        }
    }
    
    // MARK: - Private helpers
    
    private func calculateCellSize() -> CGSize {
        // Setup constants
        let interItemSpacing: CGFloat = 13.0
        let cellAspectRatio = CGFloat(388.0/333.0)
        let columns: CGFloat = 2
        let totalLabelHeight: CGFloat = 100.0
        
        // Calculate width of cell
        let totalInterItemSpacing: CGFloat = 3 * interItemSpacing
        let availableContentArea: CGFloat = view.frame.size.width - totalInterItemSpacing
        let widthofCell = availableContentArea / columns
        
        // Determine height from width
        let heightOfImage = cellAspectRatio * widthofCell
        let heightOfCell = heightOfImage + totalLabelHeight
        
        return CGSize(width: widthofCell, height: heightOfCell)
    }
}
