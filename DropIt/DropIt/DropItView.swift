//
//  DropItView.swift
//  DropIt
//
//  Created by 김예진 on 2017. 10. 16..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class DropItView: UIView {
    
    private let dropsPerRow = 10
    
    private var dropSize : CGSize {
        let size = bounds.size.width / CGFloat(dropsPerRow)
        
        return CGSize(width : size, height : size)
    }
    
    func addDrop() {
        var frame = CGRect(origin : CGPoint.zero, size : dropSize)
        frame.origin.x = CGFloat.random(max : dropsPerRow) * dropSize.width
        
        let drop = UIView(frame : frame)
        drop.backgroundColor = UIColor.random
        
        addSubview(drop)
    }

}
