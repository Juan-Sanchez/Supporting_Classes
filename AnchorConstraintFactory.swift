//
//  AnchorConstraintFactory.swift
//  Created by juan sanchez on 4/12/17.
//

import Foundation
import UIKit

class AnchorConstraintFactory {
    
    // Fill the parent view with subview.
    class func constrain(View subView: UIView, toFillParent parentView: UIView) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        // Vertical
        subView.topAnchor.constraint(equalTo: parentView.topAnchor).isActive = true
        subView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor).isActive = true
        
        // Horizontal
        subView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor).isActive = true
        subView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor).isActive = true
    }
    
    // Constrian to parent view with top constrained to top layout guide.
    class func constrain(View subView: UIView, toFillParent parentView: UIView, withTopLayoutGuide guide: UILayoutSupport) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        // Vertical
        subView.topAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true // bottom of nav bar
        subView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor).isActive = true
        
        // Horizontal
        subView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor).isActive = true
        subView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor).isActive = true
    }
    
    // Constrain to parent view with top constrained to top and bottom layout guide.
    class func constrain(View subView: UIView, toFillParent parentView: UIView, withTopLayoutGuide top: UILayoutSupport, andBottomLayoutGuide bottom: UILayoutSupport) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        // Vertical
        subView.topAnchor.constraint(equalTo: top.bottomAnchor).isActive = true // bottom of nav bar
        subView.bottomAnchor.constraint(equalTo: bottom.bottomAnchor).isActive = true
        
        // Horizontal
        subView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor).isActive = true
        subView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor).isActive = true
    }
}
