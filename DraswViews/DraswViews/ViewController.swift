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
        //Every time it touches the canvas need to append a new line.
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

class ViewController: UIViewController,UIGestureRecognizerDelegate {
    
    var canvasView = CanvasView()
    
    let squareView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.black.cgColor
        view.isUserInteractionEnabled = true
        view.layer.borderWidth = 2.0
        return view
    }()
    
    let mainImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "test.png")
        view.layer.borderColor = UIColor.black.cgColor
        view.isUserInteractionEnabled = true
        view.layer.borderWidth = 2.0
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

//        self.view.addSubview(canvasView)
//        canvasView.backgroundColor = UIColor.white
//        canvasView.frame = view.frame
//
//        self.canvasView.addSubview(squareView)
        //self.view.addSubview(squareView)
        self.view.addSubview(mainImage)
        self.mainImage.isUserInteractionEnabled = true
        
         self.mainImage.frame = CGRect(x: 50, y: 150, width: 300, height: 300)
        
        //Pan Guesture Recognizer
//        let panGuesture = UIPanGestureRecognizer(target: self, action: #selector(change(sender:)))
//        self.view.addGestureRecognizer(panGuesture)
        
        //Pinch Gesture Recognizer
        //self.squareView.frame = CGRect(x: 50, y: 150, width: 100, height: 100)
        //self.squareView.isUserInteractionEnabled = true
        //let pinchGuesture = UIPinchGestureRecognizer(target: self, action: #selector(pinch(sender:)))
        //self.mainImage.addGestureRecognizer(pinchGuesture)
        
        
        let swiper = UISwipeGestureRecognizer(target: self, action: #selector(swipe(sender:)))
        swiper.direction = UISwipeGestureRecognizer.Direction.right
        self.mainImage.addGestureRecognizer(swiper)
        
//        self.mainImage.frame = CGRect(x: 50, y: 150, width: 100, height: 100)
//        let rotateRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(rotate(sender:)))
//        //rotateRecognizer.delegate = self
//        self.mainImage.addGestureRecognizer(rotateRecognizer)
    }
    
    @objc func swipe(sender : UISwipeGestureRecognizer) {
        switch sender.direction {
    
        case UISwipeGestureRecognizer.Direction.right :
            self.mainImage.transform = CGAffineTransform(translationX: 30, y: 0)
        default:
            print("Deafult")
        }
        
        if case UISwipeGestureRecognizer.Direction.right = sender.direction {
            print("right")
        }
    }
    
    @objc func rotate(sender: UIRotationGestureRecognizer) {
        if sender.state == .began || sender.state == .changed {
            if let rotateView = sender.view {
                rotateView.transform = rotateView.transform.rotated(by: sender.rotation)
                sender.rotation = 0
            }
        }
    }
    
    @objc func pinch(sender: UIPinchGestureRecognizer) {
        guard sender.view != nil else { return }
        
        //if sender.state == .began || sender.state == .changed {
            sender.view?.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
            sender.scale = 1.0
        //}
    }
    
    
    @objc func change(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .possible:
            print("Possible state")
        case .began:
            let point = sender.location(in: nil)
            let translation = sender.translation(in: self.view)
            self.squareView.frame = CGRect(x: point.x , y: point.y, width:  translation.x, height:  translation.y)
        case .changed:
            let point = sender.location(in: nil)
            let translation = sender.translation(in: self.view)
            self.squareView.frame = CGRect(x: point.x , y: point.y, width: translation.x, height:  translation.y)
        case .ended:
            print("End State")
        case .cancelled:
            print("Cancelled State")
        case .failed:
            print("Failed State")
        }
    }
    
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
//
//        if touch.isKind(of: UIView.self) {
//            return true
//        }
//
//        return true
//    }
//
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }

}

