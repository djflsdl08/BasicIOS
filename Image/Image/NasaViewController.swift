//
//  NasaViewController.swift
//  Image
//
//  Created by 김예진 on 2017. 10. 13..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class NasaViewController: UIViewController, UISplitViewControllerDelegate {

    private struct Storyboard {
        static let ShowImageSegue = "Show Image"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.ShowImageSegue {
            if let ivc = (segue.destination.contentViewController as? ImageViewController) {
                let imageName = (sender as? UIButton)?.currentTitle
                ivc.imageURL = DemoURL.NASAImageNamed(imageName: imageName)
                ivc.title = imageName
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        splitViewController?.delegate = self
    }
    
    
    @IBAction func showImage(_ sender: UIButton) {
        if let ivc = splitViewController?.viewControllers.last?.contentViewController as? ImageViewController {
            let imageName = sender.currentTitle
            ivc.imageURL = DemoURL.NASAImageNamed(imageName: imageName)
            ivc.title = imageName
        } else {
            performSegue(withIdentifier: Storyboard.ShowImageSegue, sender: sender)
        }
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if primaryViewController.contentViewController == self {
            if let ivc = secondaryViewController.contentViewController as? ImageViewController, ivc.imageURL == nil {
                return true
            }
        }
        return false
    }
}

extension UIViewController {
    var contentViewController : UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        } else {
            return self
        }
    }
}
