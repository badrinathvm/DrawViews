//
//  ViewController.swift
//  DraswViews
//
//  Created by Badarinath Venkatnarayansetty on 1/3/19.
//  Copyright © 2019 Badarinath Venkatnarayansetty. All rights reserved.
//

import UIKit

class CanvasView: UIView {
    
    var lines = [[CGPoint]]()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return  }
        
        //dummy data
//        context.move(to: CGPoint(x: 0, y: 0))
//        context.addLine(to: CGPoint(x: 100, y: 200))
        
        
        //customise the line colors
        context.setStrokeColor(UIColor.red.cgColor)
        context.setLineWidth(10)
        context.setLineCap(.butt)
        
        lines.forEach { (line) in
            for (index, point) in line.enumerated() {
                if index == 0 {
                    context.move(to: point)
                }else {
                    context.addLine(to: point)
                }
            }
        }
        
        //this line of code just paints a line on the view.
        context.strokePath()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
        print(lines)
    }
    
    //track the finger as we move across the screen.
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //Get the point object from touches
        guard let point = touches.first?.location(in: nil) else { return }
        
        //To draw the current line.
        guard var lastLine = lines.popLast() else { return }
        lastLine.append(point)
        
        //Need to add it back to lines which will have the previous line stored, to render all of the previous ones.
        lines.append(lastLine)
        
        //need to redraw the view.
        setNeedsDisplay()
    }
}

class ViewController: UIViewController {
    
    var canvasView = CanvasView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(canvasView)
        canvasView.backgroundColor = UIColor.white
        canvasView.frame = view.frame
    }
}

