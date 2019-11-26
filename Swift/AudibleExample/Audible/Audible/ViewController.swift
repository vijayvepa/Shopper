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


    let cellId: String = "cellId"

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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)

        collectionView.anchorToView(view: view)
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: cellId)
    }

    //region Collection View Delegates

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PageCell

        cell.page = pages[indexPath.item]

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }

    //endregion

}

