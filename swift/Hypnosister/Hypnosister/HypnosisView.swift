//
//  HypnosisView.swift
//  Hypnosister
//
//  Created by Omer Wazir on 8/6/14.
//  Copyright (c) 2014 Omer Wazir. All rights reserved.
//

import UIKit

class HypnosisView: UIView {

    
//     Only override drawRect: if you perform custom drawing.
//     An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        let bounds:CGRect = self.bounds;
        let center:CGPoint = CGPoint(x: bounds.origin.x + bounds.size.width / 2.0,
            y: bounds.origin.y + bounds.size.height / 2.0);
        let radius = min(bounds.size.width, bounds.size.height) / 2.0;
        let path:UIBezierPath = UIBezierPath();
        
        //Swift can't convert type Float to CGFloat...yet
        //So doing this kinda wonky workaround of creating startAngle and endAngle constants.
        let startAngle = CGFloat(0.0);
        let endAngle = CGFloat(M_PI * 2.0);
        path.addArcWithCenter(center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true);
        path.stroke();
    
    }

}
