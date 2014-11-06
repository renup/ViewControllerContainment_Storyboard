//
//  RightViewController.swift
//  ViewControllerContainmentTest
//
//  Created by Renu Punjabi on 10/31/14.
//  Copyright (c) 2014 CocoaTeam. All rights reserved.
//

import Foundation
import UIKit

var SegueIdentifierRight1 = "customSegueToRight1VC"
var SegueIdentifierRight2 = "customSegueToRight2VC"



class RightViewController: UIViewController, LeftViewDelegate {
    
    var currentVCIdentifier = ""
    
    var right1VC: Right1ViewController?
    var right2VC: Right2ViewController?
    var transitionInProgress = false
    
    func bringUpRight2VC() {
        currentVCIdentifier = SegueIdentifierRight2
        swapViewControllers()
    }
    
    func bringUpRight1VC() {
        currentVCIdentifier = SegueIdentifierRight1
        swapViewControllers()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if segue.identifier == SegueIdentifierRight1 {
            right1VC = segue.destinationViewController as? Right1ViewController
        }
        
        if segue.identifier == SegueIdentifierRight2 {
          right2VC = segue.destinationViewController as? Right2ViewController
        }
        
        if segue.identifier == SegueIdentifierRight1 {
        // If this is not the first time we're loading this
            if self.childViewControllers.count > 0 {
                self.swapViewControllerFrom(fromViewController: self.childViewControllers[0] as Right2ViewController, toViewController: right1VC! )
                println(self.childViewControllers.count)

            }
            else {
                // If this is the very first time we're loading this we need to do
                //    // an initial load and not a swap.
                
                self.addChildViewController(right1VC!)
                var destView = right1VC?.view
                destView!.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
                destView?.frame = CGRect(x:0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                self.view.addSubview(destView!)
                right1VC?.didMoveToParentViewController(self)
                self.transitionInProgress = false
                
            }
            // By definition the second view controller will always be swapped with the
            //    // first one
        } else if (segue.identifier == SegueIdentifierRight2) {
            println(self.childViewControllers.count)
            
            // If this is not the first time we're loading this
            if self.childViewControllers.count > 0 {
                self.swapViewControllerFrom(fromViewController: self.childViewControllers[0] as Right1ViewController, toViewController: right2VC! )
//                println("printing children count \(self.childViewControllers.count)")
                
            }
            else {
                // If this is the very first time we're loading this we need to do
                //    // an initial load and not a swap.
                self.addChildViewController(right2VC!)
                var destView = right2VC?.view
                destView!.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
                destView?.frame = CGRect(x:0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                self.view.addSubview(destView!)
                right2VC?.didMoveToParentViewController(self)
                self.transitionInProgress = false
                
            }
        }

    }
    
    func swapViewControllerFrom(#fromViewController: UIViewController, toViewController: UIViewController) {
        if fromViewController == toViewController {
            transitionInProgress = false
            return
        }
        
        toViewController.view.frame = CGRect(x:0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        fromViewController.willMoveToParentViewController(nil)
        self.addChildViewController(toViewController)
        
        self.transitionFromViewController(
            fromViewController,
            toViewController: toViewController,
            duration: 0.2,
            options: UIViewAnimationOptions.TransitionCrossDissolve,
            nil,
            completion: { finished in
                fromViewController.removeFromParentViewController()
                toViewController.didMoveToParentViewController(self)
                self.transitionInProgress = false
        })
    }
    
    
    func swapViewControllers() {
        if transitionInProgress {
            return
        }
        
        transitionInProgress = true
        
        if currentVCIdentifier == SegueIdentifierRight1 {
            currentVCIdentifier = SegueIdentifierRight1
        }else {
            currentVCIdentifier = SegueIdentifierRight2
        }
        
        if (currentVCIdentifier == SegueIdentifierRight1 && right1VC != nil) {
            self.swapViewControllerFrom(fromViewController: self.childViewControllers[0] as UIViewController, toViewController: right1VC!)
            return
        }
        
        if (currentVCIdentifier == SegueIdentifierRight2 && right2VC != nil) {
            self.swapViewControllerFrom(fromViewController: self.childViewControllers[0] as UIViewController, toViewController: right2VC!)
            return
        }
        
        self.performSegueWithIdentifier(currentVCIdentifier, sender: self)
        
    }

    
}
    