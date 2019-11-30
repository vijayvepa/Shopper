//
// Created by Vijay Vepakomma on 11/29/19.
// Copyright (c) 2019 Vijay Vepakomma. All rights reserved.
//

import UIKit

class MyNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        navigationBar.isHidden = true


        perform(#selector(showLoginController), with: nil, afterDelay: 0.1)
    }

    @objc func showLoginController() {
        let loginController = LoginController()

        loginController.modalPresentationStyle = .fullScreen
        present(loginController, animated: false, completion: {})
    }
}
