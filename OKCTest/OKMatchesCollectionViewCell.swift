//
//  OKMatchesCollectionViewCell.swift
//  OKCTest
//
//  Created by Corey Zanotti on 10/20/16.
//  Copyright © 2016 Corey Zanotti. All rights reserved.
//

import UIKit

class OKMatchesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    
    var viewModel: OKMatchSearchCellViewModel? {
        didSet {
            fillUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleUI()
    }
    
    //MARK: - Configuration
    
    fileprivate func styleUI() {
        layer.borderWidth = 1.0
        layer.cornerRadius = 3.0
        layer.borderColor = UIColor.lightGray.cgColor
        
        usernameLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 14.0)
        locationLabel.font = UIFont(name: "HelveticaNeue", size: 12.0)
        percentageLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 13.0)
    }
    
    fileprivate func fillUI() {
        guard let viewModel = self.viewModel else {
            return
        }
        
        if let profileURL = viewModel.profileImageURL {
            profileImageView.kf.setImage(with: profileURL)
        }
        
        usernameLabel.text = viewModel.usernameString
        locationLabel.text = viewModel.ageAndLocationString
        percentageLabel.text = viewModel.percentageString
    }
}
