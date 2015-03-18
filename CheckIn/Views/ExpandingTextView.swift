//
//  ExpandingTextView.swift
//  CheckIn
//
//  Created by Nathan Arnold on 3/18/15.
//  Copyright (c) 2015 Nathan Arnold. All rights reserved.
// 
//  Hat Tip to https://github.com/adam-siton/AUIAutoGrowingTextView

import Foundation

class ExpandingTextView:UITextView {
    
    var heightConstraint:NSLayoutConstraint?
    var minHeight:CGFloat = 0
    var maxHeight:CGFloat = 200
    
    required init(coder aDecoder: NSCoder) {
        

        super.init(coder: aDecoder)
        
//        commonInit() 

        
    }
    
    func commonInit() {
        // If we are using auto layouts, than get a handler to the height constraint.
        for possibleConstraint in constraints() {
            
            
            if var constraint:NSLayoutConstraint? = possibleConstraint as? NSLayoutConstraint {
                if (constraint?.firstAttribute == NSLayoutAttribute.Height) {
                    heightConstraint = constraint!
                    
                }
            }
        }
        
    }
    
    
    override func awakeFromNib() {
        commonInit()
    }
    
     override func layoutSubviews() {
        super.layoutSubviews()
        
        var intrinsicSize:CGSize = self.intrinsicContentSize();
        
        self.heightConstraint?.constant = intrinsicSize.height;
        
        if self.minHeight > 0 {
            intrinsicSize.height = max(intrinsicSize.height, self.minHeight);
        }
        if self.maxHeight > 0 {
            intrinsicSize.height = min(intrinsicSize.height, self.maxHeight);
        }
        
        self.heightConstraint?.constant = intrinsicSize.height;
        
        
        if intrinsicSize.height <= self.bounds.size.height {
            var topCorrect = self.bounds.size.height - self.contentSize.height;
            topCorrect = (topCorrect<0 ? 0:topCorrect)
            self.contentOffset = CGPointMake(0, -topCorrect)
        }

        
        
    }
    
    
    

    
    override func intrinsicContentSize() -> CGSize {
        
        var intrinsicContentSize:CGSize = self.contentSize
        
        intrinsicContentSize.width +=  (self.textContainerInset.left + self.textContainerInset.right ) / 2.0
        intrinsicContentSize.height += (self.textContainerInset.top + self.textContainerInset.bottom) / 2.0

        return intrinsicContentSize

        
    }
}

