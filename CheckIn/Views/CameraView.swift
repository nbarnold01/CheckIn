//
//  CameraCollectionViewCell.swift
//  CheckIn
//
//  Created by Nathan Arnold on 3/28/15.
//  Copyright (c) 2015 Nathan Arnold. All rights reserved.
//

import UIKit


class CameraView:UIView {
    
    var lineColor = Blue
    var borderWidth:CGFloat = 4
    var shapeLayer:CAShapeLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        //        addBorder()
    }
    
    override func awakeFromNib() {
        //        addBorder()
        self.layer.cornerRadius = 4

    }
    
    override func layoutSubviews() {
        drawDashedBorder()
    }
    
    func drawDashedBorder(){
        
        if (self.shapeLayer != nil) {
            self.shapeLayer!.removeFromSuperlayer()
        }
        
        var strokeColor = Blue.CGColor
        
        var shapeLayer = CAShapeLayer()

        //creating a path
        var path = CGPathCreateMutable();
        
        let cornerRadius:CGFloat = 8.0
        
        var frame:CGRect = CGRectInset(self.bounds, self.borderWidth, self.borderWidth)
        //drawing a border around a view
        var height:CGFloat = frame.size.height - CGFloat(cornerRadius)
        CGPathMoveToPoint(path, nil, 0, height)
        
        
        CGPathMoveToPoint(path, nil, 0, frame.size.height - cornerRadius)
        CGPathAddLineToPoint(path, nil, 0, cornerRadius);
        CGPathAddArc(path, nil, cornerRadius, cornerRadius, cornerRadius, CGFloat(M_PI), CGFloat(-M_PI_2), false)
        CGPathAddLineToPoint(path, nil, frame.size.width - cornerRadius, 0);
        CGPathAddArc(path, nil, frame.size.width - cornerRadius, cornerRadius, cornerRadius, CGFloat(-M_PI_2), 0, false)
        CGPathAddLineToPoint(path, nil, frame.size.width, frame.size.height - cornerRadius);
        CGPathAddArc(path, nil, frame.size.width - cornerRadius, frame.size.height - cornerRadius, cornerRadius, 0, CGFloat(M_PI_2), false)
        CGPathAddLineToPoint(path, nil, cornerRadius, frame.size.height);
        CGPathAddArc(path, nil, cornerRadius, frame.size.height - cornerRadius, cornerRadius, CGFloat(M_PI_2),CGFloat(M_PI), false);
        
        //path is set as the _shapeLayer object's path
        shapeLayer.path = path;
        
        shapeLayer.backgroundColor = UIColor.clearColor().CGColor;
        shapeLayer.frame = frame;
        shapeLayer.masksToBounds = false;
        shapeLayer.setValue(false, forKey: "isCircle")
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.strokeColor = lineColor.CGColor
        shapeLayer.lineWidth = borderWidth;
        shapeLayer.lineDashPattern = [10,20]
        shapeLayer.lineCap = kCALineCapRound;
        
        //_shapeLayer is added as a sublayer of the view
        self.layer.addSublayer(shapeLayer)
        self.layer.cornerRadius = cornerRadius;
        
        self.shapeLayer = shapeLayer
    }
    
    
}