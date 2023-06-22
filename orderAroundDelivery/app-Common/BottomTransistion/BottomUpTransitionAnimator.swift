//
//  BottomUpTransitionAnimator.swift
//
//  Created by Admin on 30/10/18.
//  Copyright © 2018 CSS. All rights reserved.
//

import UIKit

class BottomUpTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let isPresentation: Bool
    
    init(isPresentation: Bool) {
        self.isPresentation = isPresentation
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        let duration = transitionDuration(using: transitionContext)
        
        let key = isPresentation ? UITransitionContextViewControllerKey.to : UITransitionContextViewControllerKey.from
        let controller = transitionContext.viewController(forKey: key)!
        
        var finalFrame = transitionContext.finalFrame(for: controller)
        //        var initialFrame = finalFrame
        
        if isPresentation {
            containerView.addSubview(controller.view)
        }
        
//        controller.view.frame.origin.x = isPresentation ? containerView.frame.width : finalFrame.origin.x
        controller.view.frame.origin.y = isPresentation ? containerView.frame.height : finalFrame.origin.y
        
        if !isPresentation {
//            finalFrame.origin.x = containerView.frame.width
            finalFrame.origin.y = containerView.frame.height
        }
        
        UIView.animate(withDuration: duration, animations: {
            controller.view.frame = finalFrame
        }) { _ in
            transitionContext.completeTransition(true)
        }
    }
}
