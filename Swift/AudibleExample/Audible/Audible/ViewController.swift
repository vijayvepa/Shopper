//
//  ViewController.swift
//  Audible
//
//  Created by Vijay Vepakomma on 11/25/19.
//  Copyright © 2019 Vijay Vepakomma. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0 //no gaps
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .red
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true //snap
        return cv
    }()


    let pages: [Page] = {

        let firstPage = Page(
                title: NSLocalizedString("ShareAGreatListen", comment: ""),
                message: NSLocalizedString("ShareAGreatListenMessage", comment: ""),
                imageName: "Dome")


        let secondPage = Page(
                title: NSLocalizedString("SendFromYourLibrary", comment: ""),
                message: NSLocalizedString("SendFromYourLibraryMessage", comment: ""),
                imageName: "Fountain")


        let thirdPage = Page(
                title: NSLocalizedString("SendFromThePlayer", comment: ""),
                message: NSLocalizedString("SendFromThePlayerMessage", comment: ""),
                imageName: "Lake")

        return [firstPage, secondPage, thirdPage]

    }()

    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()

        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.numberOfPages = 3
        pageControl.currentPageIndicatorTintColor = .orange

        return pageControl
    }()



    private static func getButtonAttributes() -> [NSAttributedString.Key: NSObject] {
        return [
            NSAttributedString.Key.font:  UIFont.systemFont(ofSize: 14, weight: .bold),
            NSAttributedString.Key.foregroundColor: UIColor.orange
        ]
    }

    let skipButton: UIButton = {
        let skipButton = UIButton()

        let attributedText = NSAttributedString(
                string: "Skip",
                attributes: ViewController.getButtonAttributes())

        skipButton.setAttributedTitle(attributedText, for: .normal)

        return skipButton
    }()

    let nextButton: UIButton = {
        let skipButton = UIButton()

        let attributedText = NSAttributedString(
                string: "Next",
                attributes: ViewController.getButtonAttributes())

        skipButton.setAttributedTitle(attributedText, for: .normal)

        return skipButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(skipButton)
        view.addSubview(nextButton)

        collectionView.anchorToView(view: view)
        pageControl.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor,
                topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)

        skipButton.anchor(top: view.topAnchor, left: view.leftAnchor, topConstant: 20, leftConstant: 0,
                heightConstant: 50, widthConstant: 60)
        nextButton.anchor(top: view.topAnchor,  right: view.rightAnchor, topConstant: 20,
        rightConstant: 0, heightConstant: 50, widthConstant: 60)

        registerCells()
    }

    let cellId: String = "cellId"
    let loginCellId: String = "loginCellId"

    fileprivate func registerCells() {

        collectionView.register(PageCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: loginCellId)
    }

    //region Collection View Delegates

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.item == pages.count {
            let loginCell = collectionView.dequeueReusableCell(withReuseIdentifier: loginCellId, for: indexPath)
            return loginCell
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PageCell
        cell.page = pages[indexPath.item]

        return cell
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }

    //endregion

}

