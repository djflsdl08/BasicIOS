//
//  DrawView.swift
//  TouchTracker
//
//  Created by 김예진 on 2017. 10. 30..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class DrawView: UIView {

    // MARK: - Properties
    //var currentLine: Line?    -> Only one touch at a time
    var currentLines = [NSValue: Line]()    // Multyple touch at a time
    var finishedLines = [Line]()
    
    @IBInspectable var finishedLineColor: UIColor = UIColor.black {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var currentLineColor: UIColor = UIColor.red {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var lineThickness: CGFloat = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // MARK: - function
    func strokeLine(line: Line) {
        let path = UIBezierPath()
        path.lineWidth = lineThickness
        path.lineCapStyle = CGLineCap.round
        
        path.move(to: line.begin)
        path.addLine(to: line.end)
        path.stroke()
    }
    
    // MARK: Draw
    override func draw(_ rect: CGRect) {
        print(#function)

        finishedLineColor.setStroke()
        for line in finishedLines {
            strokeLine(line: line)
        }
        /* Only one touch at a time
        if let line = currentLine {
            UIColor.red.setStroke()
            strokeLine(line: line)
        }
         */
        
        currentLineColor.setStroke()
        for(_,line) in currentLines {
            strokeLine(line: line)
        }
    }
    
    // MARK: - Touch events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        /*  -> Only one touch at a time
        let touch = touches.first!
        
        let location = touch.location(in: self)
        currentLine = Line(begin: location, end: location)
        */
        
        for touch in touches {
            let location = touch.location(in: self)
            let newLine = Line(begin: location, end: location)
            let key = NSValue(nonretainedObject: touch)
            currentLines[key] = newLine
        }
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        /*  -> Only one touch at a time
        let touch = touches.first!
        let location = touch.location(in: self)
        
        currentLine?.end = location
         */
        
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            currentLines[key]?.end = touch.location(in: self)
        }
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        /*  -> Only one touch at a time
        if var line = currentLine {
            let touch = touches.first!
            let location = touch.location(in: self)
            line.end = location
            
            finishedLines.append(line)
        }
        currentLine = nil
         */
        
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            if var line = currentLines[key] {
                line.end = touch.location(in: self)
                
                finishedLines.append(line)
                currentLines.removeValue(forKey: key)
            }
        }
        setNeedsDisplay()
    }
    
    // For example, when a call comes in, the touch is canceled.
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        
        currentLines.removeAll()
        setNeedsDisplay()
    }
}
