//
//  PicturesViewController.swift
//  CheckIn
//
//  Created by Nathan Arnold on 3/21/15.
//  Copyright (c) 2015 Nathan Arnold. All rights reserved.
//

import UIKit

class PicturesViewController:UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var pictures:Array<UIImage> = Array<UIImage>()
    
    
    
    //MARK: UICollectionView Datasource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.pictures.count
        
    }
    
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
     override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell:ImageCell = collectionView.dequeueReusableCellWithReuseIdentifier("otherImageCell", forIndexPath: indexPath) as ImageCell
        
        
        cell.imageView.image = self.pictures[(self.pictures.count-1) - indexPath.row]
        
        return cell
        
        
    }
    
    //MARK:UICollectionView Delegate Methods
    
   override func  collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        

    }
    
    
    
//    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
//        return UIEdgeInsetsMake(10, 20, 10, 20)
//    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        //20 is the margin
        var width = collectionView.frame.width - 30
        
        return CGSizeMake(width, width)
    }
}