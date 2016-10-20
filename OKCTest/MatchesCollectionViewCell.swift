//
//  MatchesCollectionViewCell.swift
//  OKCTest
//
//  Created by Corey Zanotti on 10/20/16.
//  Copyright © 2016 Corey Zanotti. All rights reserved.
//

import UIKit

class MatchesCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 3.0
        self.layer.borderColor = UIColor.lightGray.cgColor
    }

}
