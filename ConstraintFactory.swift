//
//  ConstraintFactory.swift
//  Created by juan sanchez on 4/17/17.
//

import Foundation
import UIKit

class ConstraintFactory {
    
    // Constrains trailing, top, and bottom.
    class func constrain(_ subView: UIView, toParent parentView: UIView) {
        print("NSLayoutConstraint Class")
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        //Leading
        let leading = NSLayoutConstraint(item: parentView,
                                         attribute: .leading,
                                         relatedBy: .equal,
                                         toItem: subView,
                                         attribute: .leading,
                                         multiplier: 1,
                                         constant: 0)
        parentView.addConstraint(leading)
        
        //Trailing
        let trailing = NSLayoutConstraint(item: parentView,
                                          attribute: NSLayoutAttribute.trailing,
                                          relatedBy: NSLayoutRelation.equal,
                                          toItem: subView,
                                          attribute: NSLayoutAttribute.trailing,
                                          multiplier: 1.0,
                                          constant: 0)
        parentView.addConstraint(trailing)
        
        //Bottom
        let bottom = NSLayoutConstraint(item: parentView,
                                        attribute: .bottom,
                                        relatedBy: .equal,
                                        toItem: subView,
                                        attribute: .bottom,
                                        multiplier: 1.0,
                                        constant: 0)
        
        parentView.addConstraint(bottom)
        
        //Top
        let top = NSLayoutConstraint(item: parentView,
                                     attribute: .top,
                                     relatedBy: .equal,
                                     toItem: subView,
                                     attribute: .top,
                                     multiplier: 1.0,
                                     constant: 0)
        
        
        parentView.addConstraint(top)
        
    }
    
    func constraintView(_ subView: UIView, toParent parentView: UIView, withTopLayoutGuide guide: UILayoutSupport) {
        print("NSLayoutConstraint Class")
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        //Leading
        let leading = NSLayoutConstraint(item: parentView,
                                         attribute: .trailing,
                                         relatedBy: .equal,
                                         toItem: subView,
                                         attribute: .trailing,
                                         multiplier: 1,
                                         constant: 0)
        parentView.addConstraint(leading)
        
        //Trailing
        let trailing = NSLayoutConstraint(item: parentView,
                                          attribute: NSLayoutAttribute.trailing,
                                          relatedBy: NSLayoutRelation.equal,
                                          toItem: subView,
                                          attribute: NSLayoutAttribute.trailing,
                                          multiplier: 1.0,
                                          constant: 0)
        parentView.addConstraint(trailing)
        
        //Bottom
        let bottom = NSLayoutConstraint(item: parentView,
                                        attribute: .bottom,
                                        relatedBy: .equal,
                                        toItem: subView,
                                        attribute: .bottom,
                                        multiplier: 1.0,
                                        constant: 0)
        
        parentView.addConstraint(bottom)
        
        //Top
        let top = NSLayoutConstraint(item: guide,
                                     attribute: .bottom,
                                     relatedBy: .equal,
                                     toItem: subView,
                                     attribute: .top,
                                     multiplier: 1.0,
                                     constant: 0)
        
        
        parentView.addConstraint(top)
    }
    
    
}
