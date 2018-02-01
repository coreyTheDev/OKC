//
//  MatchesCollectionViewCell.swift
//  OKCTest
//
//  Created by Corey Zanotti on 10/20/16.
//  Copyright © 2016 Corey Zanotti. All rights reserved.
//

import UIKit

class MatchesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 3.0
        self.layer.borderColor = UIColor.lightGray.cgColor
    }

    // MARK: - Public
    
    func configure(with match: Match) {
        let url = URL(string: match.image!.largeURL!)
        profileImageView.kf.setImage(with: url)
        
        usernameLabel.text = match.name!
        
        let dotChar = "\u{2022}"
        locationLabel.text = "\(match.age!) \(dotChar) \(match.location!.cityName!), \(match.location!.countryCode!)"
        percentageLabel.text = "\(match.percentageMatch!)% Match"
    }
    
}
