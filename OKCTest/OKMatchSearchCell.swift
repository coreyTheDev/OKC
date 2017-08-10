//
//  OKMatchesCollectionViewCell.swift
//  OKCTest
//
//  Created by Corey Zanotti on 10/20/16.
//  Copyright © 2016 Corey Zanotti. All rights reserved.
//

import UIKit

let kMatchSearchCellReuseIdentifier = "OKMatchSearchCell"
let kMatchSearchContentViewSize = CGFloat(95.0)
fileprivate let kCellCornerRadius = CGFloat(3.0)

class OKMatchSearchCell: UICollectionViewCell {
    
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
        setupLayer()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: kCellCornerRadius).cgPath
    }
    
    //MARK: - Configuration
    
    fileprivate func styleUI() {
        usernameLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 14.0)
        locationLabel.font = UIFont(name: "HelveticaNeue", size: 12.0)
        percentageLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 13.0)
    }
    
    fileprivate func setupLayer() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = kCellCornerRadius
        
        layer.shadowColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1.0).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = kCellCornerRadius
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
