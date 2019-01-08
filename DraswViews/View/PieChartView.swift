//
//  PieChartView.swift
//  DraswViews
//
//  Created by Badarinath Venkatnarayansetty on 1/7/19.
//  Copyright © 2019 Badarinath Venkatnarayansetty. All rights reserved.
//

import Foundation
import UIKit


struct Segment {
    var color: UIColor
    var value: CGFloat
}

class PieChartView: UIView {
    
    var segments = [Segment]() {
        didSet{
            //re draw the view when value gets set
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        //Get the context
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        //Get the radius
        let radius = min(frame.size.width, frame.size.height) * 0.5
        
        //Get the center
        let center = CGPoint(x: bounds.size.width * 0.5 , y: bounds.size.height * 0.5)
        
        //segment total value
        let totalValue = segments.reduce(0 , { $0 + $1.value })
        
        //start angle = -90
        var startAngle = -CGFloat.pi * 0.5
        
        for segment in segments {
            
            let endAngle = startAngle + 2 * .pi * (segment.value / totalValue)
            
            context.setFillColor(segment.color.cgColor)
            context.move(to: center)
            context.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
            context.fillPath()
            
            //update start angle for the next iteration.
            startAngle = endAngle
        }
    }
}
