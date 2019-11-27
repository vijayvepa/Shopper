//
//  ViewController.swift
//  Audible
//
//  Created by Vijay Vepakomma on 11/25/19.
//  Copyright © 2019 Vijay Vepakomma. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,
        UICollectionViewDelegateFlowLayout {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0 //no gaps
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
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

    var pageControlConstraints: Constraints?
    var nextButtonConstraints: Constraints?
    var skipButtonConstraints: Constraints?

    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()

        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.numberOfPages = pages.count + 1
        pageControl.currentPageIndicatorTintColor = .orange

        return pageControl
    }()

    let buttonAttributes = [
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold),
        NSAttributedString.Key.foregroundColor: UIColor.orange
    ]

    lazy var skipButton: UIButton = {
        let skipButton = UIButton()

        let attributedText = NSAttributedString(
                string: NSLocalizedString("Skip", comment: "Skip"),
                attributes: buttonAttributes)

        skipButton.setAttributedTitle(attributedText, for: .normal)

        skipButton.addTarget(
                self,
                action: #selector(skipToLastPage),
                for: UIControl.Event.touchUpInside
        )


        return skipButton
    }()

    lazy var nextButton: UIButton = {
        let nextButton = UIButton()

        let attributedText = NSAttributedString(
                string: NSLocalizedString("Next", comment: "Next"),
                attributes: buttonAttributes)

        nextButton.setAttributedTitle(attributedText, for: .normal)
        nextButton.addTarget(
                self,
                action: #selector(goToNextPage),
                for: UIControl.Event.touchUpInside
        )

        return nextButton
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(skipButton)
        view.addSubview(nextButton)

        collectionView.anchorToView(view: view)
        pageControlConstraints = pageControl.anchorWithConstraints(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor,
                right:
                view.rightAnchor,
                topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)

        skipButtonConstraints = skipButton.anchorWithConstraints(top: view.topAnchor, left: view.leftAnchor, topConstant: 20, leftConstant: 0,
                heightConstant: 50, widthConstant: 60)
        nextButtonConstraints = nextButton.anchorWithConstraints(top: view.topAnchor, right: view.rightAnchor, topConstant: 20,
                rightConstant: 0, heightConstant: 50, widthConstant: 60)

        registerCells()

        observeKeyboardNotifications()
    }

    let cellId: String = "cellId"
    let loginCellId: String = "loginCellId"

    fileprivate func registerCells() {

        collectionView.register(PageCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(LoginCell.self, forCellWithReuseIdentifier: loginCellId)
    }

    //region Collection View Delegates

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.item == pages.count {
            let loginCell = collectionView.dequeueReusableCell(withReuseIdentifier: loginCellId, for: indexPath) as! LoginCell
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

    //region Update Page Control Status
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)

        pageControl.currentPage = pageNumber

        moveControlsOffScreen(pageNumber: pageNumber)
    }

    private func moveControlsOffScreen(pageNumber: Int) {
        if pageNumber == pages.count {
            pageControlConstraints?.bottomConstraint?.constant = 40
            skipButtonConstraints?.topConstraint?.constant = -40
            nextButtonConstraints?.topConstraint?.constant = -40
        } else {
            pageControlConstraints?.bottomConstraint?.constant = 0
            skipButtonConstraints?.topConstraint?.constant = 0
            nextButtonConstraints?.topConstraint?.constant = 0
        }

        UIView.animate(
                withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 1,
                options: .curveEaseOut,
                animations: {
                    self.view.layoutIfNeeded()
                },
                completion: nil
        )
    }

    //endregion

    //region Hide Keyboard on Scroll

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }

    //endregion

    //region Change UI when Keyboard Active

    fileprivate func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShown), name: UIResponder
                .keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHidden), name: UIResponder
                .keyboardWillHideNotification, object: nil)

    }


    @objc func keyboardShown() {
        print("keyboard shown")

        animateFramePosition(yPosition: -50)

    }

    @objc func keyboardHidden() {
        print("keyboard hidden")

        animateFramePosition(yPosition: 0)

    }

    private func animateFramePosition(yPosition: CGFloat) {
        UIView.animate(
                withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 1,
                options: .curveEaseOut,
                animations: {
                    self.view.frame = CGRect(x: 0, y: yPosition, width: self.view.frame.width, height: self.view.frame
                            .height)
                },
                completion: nil
        )
    }

    //endregion

    //region Next and Skip Button Handling
    @objc func goToNextPage() {

        if pageControl.currentPage == pages.count {
            return
        }

        scrollToPage(targetPage: pageControl.currentPage + 1)

        moveControlsOffScreen(pageNumber: pageControl.currentPage)
    }

    private func scrollToPage(targetPage: Int) {

        let indexPath = IndexPath(item: targetPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally,
                animated: true)
        pageControl.currentPage = targetPage
    }

    @objc func skipToLastPage() {

        if pageControl.currentPage == pages.count {
            return
        }

        scrollToPage(targetPage: pages.count)

        moveControlsOffScreen(pageNumber: pageControl.currentPage)
    }

    //endregion
}

