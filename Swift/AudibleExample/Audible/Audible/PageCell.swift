//
//  PageCell.swift
//  Audible
//
//  Created by Vijay Vepakomma on 11/25/19.
//  Copyright © 2019 Vijay Vepakomma. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    let lineSeparatorView: UIView = {
        let uiView = UIView()

        uiView.backgroundColor = .orange

        return uiView
    }()

    let textView: UITextView = {

        let textView = UITextView()

        textView.isEditable = false
        textView.isSelectable = false

        textView.contentInset = UIEdgeInsets(top: 24, left: 16, bottom: 0, right: 16)
        return textView
    }()

    let imageView: UIImageView = {

        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .yellow
        iv.image = UIImage(named: "Dome")
        iv.clipsToBounds = true //fix the flicker
        return iv
    }()

    func setupViews() {

        addSubview(imageView)
        addSubview(textView)
        addSubview(lineSeparatorView)

        arrangeControls()

    }

    private func arrangeControls() {

        textView.clearConstraints()
        imageView.clearConstraints()
        lineSeparatorView.clearConstraints()


        if UIDevice.current.orientation.isLandscape {
            layoutLandscapeMode()
        } else {
            layoutPortraitMode()
        }
    }

    private func layoutPortraitMode() {
        imageView.anchorToTop(top: topAnchor, left: leftAnchor, bottom: textView.topAnchor, right: rightAnchor)

        textView.anchor(
                top: nil,
                left: leftAnchor,
                bottom: bottomAnchor,
                right: rightAnchor,
                topConstant: 0,
                leftConstant: 0,
                bottomConstant: 0,
                rightConstant: 0)


        lineSeparatorView.anchorToTop(top: nil, left: leftAnchor, bottom: textView.topAnchor, right: rightAnchor)
        lineSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true

        textView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
    }

    private func layoutLandscapeMode() {
        imageView.anchorToTop(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil)
        imageView.widthAnchor.constraint(equalToConstant: frame.width / 2).isActive = true


        textView.anchor(
                top: centerYAnchor,
                left: imageView.rightAnchor,
                bottom: nil,
                right: rightAnchor,
                topConstant: (frame.height * -0.2),
                leftConstant: 0,
                bottomConstant: 0,
                rightConstant: 0)

        lineSeparatorView.anchorToTop(top: topAnchor, left: nil, bottom: bottomAnchor, right:
        textView.leftAnchor)
        lineSeparatorView.widthAnchor.constraint(equalToConstant: 1).isActive = true

        textView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var page: Page? {
        didSet {
            guard let page = page else {
                return
            }

            var imageName: String = page.imageName

            if UIDevice.current.orientation.isLandscape {
                imageName = page.landscapeImageName
            }

            imageView.image = UIImage(named: imageName)

            let color = UIColor(white: 0.2, alpha: 1)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center

            let pageTitle: NSMutableAttributedString = NSMutableAttributedString(string: page.title,
                    attributes: [
                        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium),
                        NSAttributedString.Key.foregroundColor: color

                    ])

            let pageMessage: NSMutableAttributedString = NSMutableAttributedString(string: "\n\n\(page.message)",
                    attributes: [
                        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium),
                        NSAttributedString.Key.foregroundColor: color
                    ])

            pageTitle.append(pageMessage)

            pageTitle.addAttribute(
                    NSAttributedString.Key.paragraphStyle,
                    value: paragraphStyle,
                    range: NSRange(location: 0, length: pageTitle.string.count)
            )

            textView.attributedText = pageTitle

            arrangeControls()

        }
    }

}
