//
//  VisualConstraintFactory.swift
//  Created by juan sanchez on 4/12/17.
//

import Foundation
import UIKit

class VisualConstraintFactory {
    
    
    class func visuallyConstrain(_ subView: UIView, toParent parentView: UIView) {
        print("Visual")
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        var allConstraints = [NSLayoutConstraint]()
        // Declare views
        let views = ["subView" : subView,
                     "parentView" : parentView]
        
        // format subview
        let subViewHorizontalConstraints =  NSLayoutConstraint.constraints(
            withVisualFormat: "|-0-[subView]-0-|",    // zero space with super for leading and trailing
            options: [],
            metrics: nil,
            views: views)
        allConstraints += subViewHorizontalConstraints
        
        let subViewVerticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[subView]-0-|",  // zero space top and bottom to super
            options: [],
            metrics: nil,
            views: views)
        allConstraints += subViewVerticalConstraints
        
        
        NSLayoutConstraint.activate(allConstraints)
    }
}
