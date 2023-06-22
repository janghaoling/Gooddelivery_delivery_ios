//
//  BottomUpTransitionDelegate.swift
//  Created by Admin on 30/10/18.
//  Copyright © 2018 CSS. All rights reserved.
//

import UIKit

class BottomUpTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return BottomUpPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BottomUpTransitionAnimator(isPresentation: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BottomUpTransitionAnimator(isPresentation: false)
    }
}
