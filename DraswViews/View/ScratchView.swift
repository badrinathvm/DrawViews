//
//  ScratchView.swift
//  DraswViews
//
//  Created by Badarinath Venkatnarayansetty on 1/7/19.
//  Copyright © 2019 Badarinath Venkatnarayansetty. All rights reserved.
//

import Foundation
import UIKit

class ScratchView : UIView {
    
    var lines:[[CGPoint]] = []
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
//        context.move(to: CGPoint(x: 20, y: 20))
//        context.addLine(to: CGPoint(x:50, y:50))
        
        lines.forEach { line in
            for (i , p) in line.enumerated() {
                if i == 0 {
                     context.move(to: p)
                }else {
                    context.addLine(to: p)
                }
            }
        }
        
        context.setStrokeColor(UIColor.red.cgColor)
        context.setLineWidth(2.0)
        context.setLineCap(.round)
        context.strokePath()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let point = touches.first?.location(in: nil) else { return }
        //get the last line
        guard var lastLine = lines.popLast() else  { return }
        lastLine.append(point)
        lines.append(lastLine)
        setNeedsDisplay()
    }
}
