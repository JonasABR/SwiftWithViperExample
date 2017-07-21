//
//  TransitionAnimator.swift
//  ArticleSearcher
//
//  Created by Avenue Code on 7/21/17.
//  Copyright © 2017 jonas. All rights reserved.
//

import UIKit

class TransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning, UINavigationControllerDelegate {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)! as! ReaderViewController
        let containerView = transitionContext.containerView
        containerView.addSubview(toViewController.view)
        
        toViewController.view.layer.cornerRadius = toViewController.view.frame.width / 2
        toViewController.view.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
        toViewController.view.clipsToBounds = true
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            toViewController.view.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: {
            finished in
            transitionContext.completeTransition(true)
            toViewController.view.layer.cornerRadius = 0
        })
    }
    
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        if(operation == .push){
            return self
        }else{
            return nil
        }
        
    }

}
