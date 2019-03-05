//
//  CustomPftimeAnimationControll.swift
//  CreateApp
//
//  Created by Sonnv on 3/5/19.
//  Copyright © 2019 Sonnv. All rights reserved.
//

import UIKit

//class CustomPresentAnimationController: NSObject {
//
//    private let animationDuration: Double
//    private let animationType: AnimationType
//
//
//    enum AnimationType {
//        case present
//        case dismiss
//    }
//
//    init(animationDuration: Double, animationType: AnimationType) {
//        self.animationDuration = animationDuration
//        self.animationType = animationType
//    }
//}
//
//extension CustomPresentAnimationController: UIViewControllerAnimatedTransitioning {
//
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return TimeInterval(exactly: animationDuration) ?? 0
//    }
//
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        guard let toVC = transitionContext.viewController(forKey: .to),
//            let fromVC = transitionContext.viewController(forKey: .from) else {
//            transitionContext.completeTransition(false)
//            return
//        }
//
//        switch animationType {
//        case .present:
//            transitionContext.containerView.addSubview(toVC.view)
//            presentAnimation(with: transitionContext, viewToAnimation: toVC.view)
//        case .dismiss:
//            print("abc")
//        }
//    }
//    func presentAnimation(with transitionContext: UIViewControllerContextTransitioning, viewToAnimation: UIView) {
//        viewToAnimation.clipsToBounds = true
//        viewToAnimation.transform = CGAffineTransform(scaleX: 0, y: 0)
//
//        let duration = transitionDuration(using: transitionContext)
//        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.80, initialSpringVelocity: 0.1, options: .curveEaseInOut, animations: {
//            viewToAnimation.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//        }) { _ in
//            transitionContext.completeTransition(true)
//        }
//    }
//}
