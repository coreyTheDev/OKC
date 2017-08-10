//
//  OKMatchesCollectionViewController.swift
//  OKCTest
//
//  Created by Corey Zanotti on 10/20/16.
//  Copyright © 2016 Corey Zanotti. All rights reserved.
//

import UIKit


private let margin = 13.0
private let cellAspectRatio = CGFloat(388.0/333.0)

let kResultsFetchCompleted = "kResultsFetchCompleted"

class OKMatchesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    //var matchesArray:[OKMatch] = [OKMatch]()
    
    let matchSearchViewModel = OKMatchSearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNotifications()
    }

    // MARK: setup
    
    fileprivate func setupUI() {
        self.title = "Browse"
        let textColorDictionary: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textColorDictionary as? [String : Any]
        self.collectionView?.register(UINib(nibName:"OKMatchSearchCell", bundle: Bundle.main), forCellWithReuseIdentifier: kMatchSearchCellReuseIdentifier)
    }
    
    fileprivate func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(resultsUpdated), name: NSNotification.Name(kResultsFetchCompleted), object: nil)
    }

    // MARK: Notification handling
    
    @objc fileprivate func resultsUpdated() {
        collectionView?.reloadData()
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.matchSearchViewModel.numberOfRows()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let matchCell = collectionView.dequeueReusableCell(withReuseIdentifier: kMatchSearchCellReuseIdentifier, for: indexPath) as? OKMatchSearchCell else {
            return UICollectionViewCell()
        }
        
        matchCell.viewModel = matchSearchViewModel.modelForCell(at: indexPath)
        return matchCell
    }
    
    //MARK: UICollectionViewFlowLayout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthofCell = (collectionView.frame.size.width - CGFloat(3 * margin))/2
        //determine height of image given width of cell and add constant value for labels
        let heightOfImage = cellAspectRatio * widthofCell
        
        let heightOfCell = heightOfImage + 100.0
        return CGSize(width: widthofCell, height: heightOfCell)
    }

    
}
