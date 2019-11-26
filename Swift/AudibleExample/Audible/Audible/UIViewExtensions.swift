//
//  UIViewExtensions.swift
//  Audible
//
//  Created by Vijay Vepakomma on 11/26/19.
//  Copyright © 2019 Vijay Vepakomma. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    func anchorToView(view: UIView) {
        anchorToTop(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }

    func anchorToTop(top: NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil,
                     left: NSLayoutAnchor<NSLayoutXAxisAnchor>? = nil,
                     bottom: NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil,
                     right: NSLayoutAnchor<NSLayoutXAxisAnchor>? = nil) {

        anchorWithConstantsToTop(top: top, left: left, bottom: bottom, right: right, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
    }

    func anchorWithConstantsToTop(
            top: NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil,
            left: NSLayoutAnchor<NSLayoutXAxisAnchor>? = nil,
            bottom: NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil,
            right: NSLayoutAnchor<NSLayoutXAxisAnchor>? = nil,
            topConstant: CGFloat = 0,
            leftConstant: CGFloat = 0,
            bottomConstant: CGFloat = 0,
            rightConstant: CGFloat = 0) {

        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            topAnchor.constraint(equalTo: top, constant: topConstant).isActive = true
        }

        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: leftConstant).isActive = true
        }

        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: bottomConstant).isActive = true
        }

        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: rightConstant).isActive = true
        }

    }
}
