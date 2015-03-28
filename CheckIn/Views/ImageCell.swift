//
//  ImageCell.swift
//  CheckIn
//
//  Created by Nathan Arnold on 3/19/15.
//  Copyright (c) 2015 Nathan Arnold. All rights reserved.
//

import UIKit
import QuartzCore


class ImageCell: UICollectionViewCell {
    @IBOutlet weak var imageView : UIImageView!
    
    override func awakeFromNib() {
        
        self.imageView.layer.cornerRadius = 4
        self.imageView.clipsToBounds = true
    }
    
    
}