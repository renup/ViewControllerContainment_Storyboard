//
//  ContainerViewController.swift
//  ViewControllerContainmentTest
//
//  Created by Renu Punjabi on 10/31/14.
//  Copyright (c) 2014 CocoaTeam. All rights reserved.
//

import Foundation
import UIKit

class ContainerViewController: UIViewController {
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var leftVCObj:LeftViewController? = nil
        var rightVCObj:RightViewController? = nil
        
        for childVC in self.childViewControllers {
            if childVC.isKindOfClass(LeftViewController) {
                leftVCObj = childVC as? LeftViewController
            }
            else{
                if childVC.isKindOfClass(RightViewController) {
                    rightVCObj = childVC as? RightViewController
                }
            }
        }
        
        leftVCObj?.leftDelegate = rightVCObj
//        orderHistDetailVCObj?.orderDetailDelegate = orderHistVCObj
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
