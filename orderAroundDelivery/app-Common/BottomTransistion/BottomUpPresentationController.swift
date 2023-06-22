//
//  BottomUpPresentationController.swift
//  
//
//  Created by Admin on 30/10/18.
//  Copyright © 2018 CSS. All rights reserved.
//

import UIKit

class BottomUpPresentationController: UIPresentationController {
    
    private var dimmingView: UIView!
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        setupDimmingView()
    }
    
    override func presentationTransitionWillBegin() {
        containerView?.insertSubview(dimmingView, at: 0)
        
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|[dimmingView]|", options: [], metrics: nil, views: ["dimmingView" : dimmingView]))
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[dimmingView]|", options: [], metrics: nil, views: ["dimmingView" : dimmingView]))
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1.0
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1.0
        })
    }
    
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 0.0
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0.0
        })
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        var rect: CGRect = .zero
        rect.size = size(forChildContentContainer: presentingViewController, withParentContainerSize: containerView!.bounds.size)
//        rect.origin.x = containerView!.frame.width * (0.5 / 3.0)
        rect.origin.y = containerView!.frame.height * (1.8 / 2.8)
        return rect
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
//        return CGSize(width: parentSize.width * (2.5 / 3.0), height: parentSize.height)
        return CGSize(width: parentSize.width, height: parentSize.height * (1.2 / 2.8))
    }
}


extension BottomUpPresentationController {
    private func setupDimmingView() {
        dimmingView = UIView()
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.15)
        dimmingView.alpha = 0.0
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDimmingViewTapped))
        dimmingView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleDimmingViewTapped() {
        presentingViewController.dismiss(animated: true)
    }
}
