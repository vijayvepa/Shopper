//
// Created by Vijay Vepakomma on 11/26/19.
// Copyright (c) 2019 Vijay Vepakomma. All rights reserved.
//

import UIKit

class LeftPaddedTextField : UITextField {

    var padding: CGFloat = 10

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return paddedRect(bounds: bounds)
    }

    private func paddedRect(bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + padding, y: bounds.origin.y, width: bounds.width + padding, height: bounds
                .height)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return paddedRect(bounds: bounds)
    }
}
