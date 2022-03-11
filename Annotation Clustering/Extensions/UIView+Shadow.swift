//
//  UIView+Shadow.swift
//  Annotation Clustering
//
//  Created by Artyom Gurbovich on 11.03.22.
//

import UIKit

extension UIView {
    
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 5
    }
}
