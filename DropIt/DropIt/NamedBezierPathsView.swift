//
//  NamedBezierPathsView.swift
//  DropIt
//
//  Created by 김예진 on 2017. 10. 17..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class NamedBezierPathsView: UIView {

    var bezierPaths = [String : UIBezierPath]() { didSet { setNeedsDisplay() } }
   
    override func draw(_ rect: CGRect) {
        for (_, path) in bezierPaths {
            path.stroke()
        }
    }
    

}
