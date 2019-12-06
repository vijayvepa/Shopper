//
// Created by Vijay Vepakomma on 12/5/19.
// Copyright (c) 2019 Vijay Vepakomma. All rights reserved.
//

import UIKit
import SwipeViewFramework

class SwipeView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    //region Controls

    lazy var collectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0 //no gaps
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .blue
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true //snap
        return cv
    }()

    //endregion


    func getViewCells() -> [PageInfo] {
        return []
    }

    func configureViewCell(viewCell: UICollectionViewCell) -> UICollectionViewCell {
        return viewCell
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)

        let viewCells = getViewCells()
        viewCells.forEach { viewCell in
            collectionView.register(viewCell.type, forCellWithReuseIdentifier: viewCell.id)
        }

        collectionView.anchorToView(view: view)
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        print(UIDevice.current.orientation.isLandscape)
        view.layoutIfNeeded()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getViewCells().count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let pageCellItem = getViewCells()[indexPath.item]

        let viewCell = collectionView.dequeueReusableCell(withReuseIdentifier: pageCellItem.id, for: indexPath)

        let configuredViewCell = configureViewCell(viewCell: viewCell)

        return configuredViewCell
    }

    //show  page in full screen
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}