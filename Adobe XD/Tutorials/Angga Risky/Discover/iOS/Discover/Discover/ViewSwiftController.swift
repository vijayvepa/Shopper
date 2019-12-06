//
//  ViewController.swift
//  Discover
//
//  Created by Vijay Vepakomma on 11/25/19.
//  Copyright © 2019 Vijay Vepakomma. All rights reserved.
//

import UIKit

class ViewSwiftController: SwipeView {

    override func getViewCells() -> [PageInfo] {
        return [
            PageInfo(id: "discoverPage", type: DiscoverPage.self), 
            PageInfo(id: "discoverPageYellow", type: DiscoverPageYellow.self)]
    }

    override func configureViewCell(viewCell: UICollectionViewCell) -> UICollectionViewCell {
        viewCell.backgroundColor = .orange
        return viewCell
    }
}

