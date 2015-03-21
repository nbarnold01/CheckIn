//
//  PicturesViewController.swift
//  CheckIn
//
//  Created by Nathan Arnold on 3/21/15.
//  Copyright (c) 2015 Nathan Arnold. All rights reserved.
//

import UIKit

class PicturesViewController:UICollectionViewController {
    
    var pictures:Array<UIImage> = Array<UIImage>()
    
    
    
    //MARK: UICollectionView Datasource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1 + self.pictures.count
        
    }
//    
//    
//    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
//    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        
//        
//        
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("imageCell", forIndexPath: indexPath) as ImageCell
//        
//        
//        if (indexPath.row == 0){
//            cell.imageView.image = nil;
//            cell.backgroundColor = UIColor.greenColor()
//            
//        } else {
//            cell.imageView.image = self.pictures[self.pictures.count - indexPath.row]
//        }
//        
//        return cell
//        
//        
//    }
    
    //MARK:UICollectionView Delegate Methods
    
   override func  collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        

    }
    
    
    
    
    
}