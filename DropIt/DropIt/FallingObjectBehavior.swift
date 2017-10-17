//
//  FallingObjectBehavior.swift
//  DropIt
//
//  Created by 김예진 on 2017. 10. 16..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class FallingObjectBehavior: UIDynamicBehavior {

    let gravity = UIGravityBehavior()
   
    private let collider : UICollisionBehavior = {
        let collider = UICollisionBehavior()
        collider.translatesReferenceBoundsIntoBoundary = true
        return collider
    }()
    
    private let itemBehavior : UIDynamicItemBehavior = {
       let dib = UIDynamicItemBehavior()
        dib.allowsRotation = false
        dib.elasticity = 0.75
        return dib
    }()
    
    func addBarrier(path : UIBezierPath, named name : String) {
        collider.removeBoundary(withIdentifier: name as NSCopying)
        collider.addBoundary(withIdentifier: name as NSCopying, for: path)
    }
    
    override init() {
        super.init()
        addChildBehavior(gravity)
        addChildBehavior(collider)
        addChildBehavior(itemBehavior)
    }
    
    func addItem(item : UIDynamicItem) {
        gravity.addItem(item)
        collider.addItem(item)
        itemBehavior.addItem(item)
    }
    
    func removeItem(item : UIDynamicItem) {
        gravity.removeItem(item)
        collider.removeItem(item)
        itemBehavior.removeItem(item)
    }
}
