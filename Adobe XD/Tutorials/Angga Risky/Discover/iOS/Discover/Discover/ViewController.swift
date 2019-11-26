//
//  ViewController.swift
//  Discover
//
//  Created by Vijay Vepakomma on 11/25/19.
//  Copyright © 2019 Vijay Vepakomma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        print(UIDevice.current.orientation.isLandscape)
        
        view.reloadInputViews()
    }

}

