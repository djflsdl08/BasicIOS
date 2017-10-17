//
//  DropItView.swift
//  DropIt
//
//  Created by 김예진 on 2017. 10. 16..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class DropItView: NamedBezierPathsView, UIDynamicAnimatorDelegate {
    
    private lazy var animator : UIDynamicAnimator = {
        let animator = UIDynamicAnimator(referenceView : self)
        animator.delegate = self
        return animator
    }()

    func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
        removeCompletedRow()
    }
    
    private let dropBehavior = FallingObjectBehavior()
    
    var animating : Bool = false {
        didSet {
            if animating {
                animator.addBehavior(dropBehavior)
            } else {
                animator.removeBehavior(dropBehavior)
            }
        }
    }
    
    private struct PathNames {
        static let MiddleBarrier = "Middle Barrier"
        static let Attachment = "Attachment"
    }
    
    private var attachment : UIAttachmentBehavior? {
        // willSet happens before the new value get,set.
        willSet {
            if attachment != nil {
                animator.removeBehavior(attachment!)
                bezierPaths[PathNames.Attachment] = nil
            }
        }
        didSet {
            if attachment != nil {
                animator.addBehavior(attachment!)
                attachment!.action = { [unowned self] in
                    if let attachedDrop = self.attachment!.items.first as? UIView {
                        self.bezierPaths[PathNames.Attachment] = UIBezierPath.lineFrom(from: (self.attachment?.anchorPoint)!, to: attachedDrop.center)
                    }
                }
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let path = UIBezierPath(ovalIn : CGRect(center : bounds.mid, size : dropSize))
        dropBehavior.addBarrier(path: path, named: PathNames.MiddleBarrier)
        bezierPaths[PathNames.MiddleBarrier] = path // I can see the circle.
    }
    
    private func removeCompletedRow() {
        var dropsToRemove = [UIView]()
        var hitTestRect = CGRect(origin : bounds.lowerLeft, size : dropSize)
        repeat {
            hitTestRect.origin.x = bounds.minX
            hitTestRect.origin.y -= dropSize.height
            var dropsTested = 0
            var dropsFound = [UIView]()
            while dropsTested < dropsPerRow {
                if let hitView = hitTest(p: hitTestRect.mid), hitView.superview == self {
                    dropsFound.append(hitView)
                } else {
                    break
                }
                hitTestRect.origin.x += dropSize.width
                dropsTested += 1
            }
            if dropsTested == dropsPerRow {
                dropsToRemove += dropsFound
            }
        } while dropsToRemove.count == 0 && hitTestRect.origin.y > bounds.minY
        
        for drop in dropsToRemove {
            dropBehavior.removeItem(item: drop)
            drop.removeFromSuperview()
        }
    }
    
    func grabDrop(recognizer : UIPanGestureRecognizer) {
        let gesturePoint = recognizer.location(in: self)
        switch recognizer.state {
        case .began : // create the attachment
            if let dropToAttachTo = lastDrop, dropToAttachTo.superview != nil {
                attachment = UIAttachmentBehavior(item : dropToAttachTo, attachedToAnchor : gesturePoint)
            }
            lastDrop = nil
        case .changed : // change the attachment's anchor point
            attachment?.anchorPoint = gesturePoint
        default : attachment = nil
        }
    }
    
    private let dropsPerRow = 10
    
    private var dropSize : CGSize {
        let size = bounds.size.width / CGFloat(dropsPerRow)
        
        return CGSize(width : size, height : size)
    }
    
    private var lastDrop : UIView?
    
    func addDrop() {
        var frame = CGRect(origin : CGPoint.zero, size : dropSize)
        frame.origin.x = CGFloat.random(max : dropsPerRow) * dropSize.width
        
        let drop = UIView(frame : frame)
        drop.backgroundColor = UIColor.random
        
        addSubview(drop)
        dropBehavior.addItem(item: drop)
        lastDrop = drop
    }

}
