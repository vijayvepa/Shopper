//
// Created by Vijay Vepakomma on 11/26/19.
// Copyright (c) 2019 Vijay Vepakomma. All rights reserved.
//

import UIKit

class LoginCell: UICollectionViewCell {

    let audibleLogo: UIImageView = {

        let audibleLogoImage = UIImage(named: "Audible")
        let audibleLogo = UIImageView(image: audibleLogoImage)

        return audibleLogo
    }()

    let emailTextField: LeftPaddedTextField = {

        let emailTextField = LeftPaddedTextField()
        emailTextField.padding = 10
        emailTextField.placeholder = NSLocalizedString("EnterEmail", comment: "EnterEmail")
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        emailTextField.layer.borderWidth = 1
        emailTextField.keyboardType = .emailAddress
        return emailTextField

    }()

    let passwordTextField: LeftPaddedTextField = {

        let passwordTextField = LeftPaddedTextField()

        passwordTextField.padding = 10
        passwordTextField.placeholder = NSLocalizedString("EnterPassword", comment: "EnterPassword")
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.borderWidth = 1
        passwordTextField.isSecureTextEntry = true

        return passwordTextField

    }()

    let loginButton: UIButton = {

        let button = UIButton()

        button.backgroundColor = .orange
        button.setTitleColor(.white, for: .normal)
        button.setTitle(
                NSLocalizedString("Login", comment: "Login"),
                for: .normal
        )

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(audibleLogo)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)


        audibleLogo.anchorToCenter(centerX: centerXAnchor, centerY: centerYAnchor, offsetFromCenter: -200,
                width: 160, height: 160)


        emailTextField.anchor(top: audibleLogo.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor,
                topConstant: 8, leftConstant: 32, bottomConstant: 0, rightConstant: -32, heightConstant: 50,
                widthConstant: 0)


        passwordTextField.anchor(top: emailTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor,
                topConstant: 16, leftConstant: 32, bottomConstant: 0, rightConstant: -32, heightConstant: 50,
                widthConstant: 0)

        loginButton.anchor(top: passwordTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor,
                topConstant: 16, leftConstant: 32, bottomConstant: 0, rightConstant: -32, heightConstant: 50,
                widthConstant: 0)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
