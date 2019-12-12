//
//  ViewController.swift
//  Discover
//
//  Created by Vijay Vepakomma on 11/25/19.
//  Copyright © 2019 Vijay Vepakomma. All rights reserved.
//

import UIKit
import SwipeViewFramework

class ViewSwiftController: SwipeView {

    override open func getViewCells() -> [PageInfo] {
        return [
            PageInfo(id: "discoverPage", type: DiscoverPage.self), 
            PageInfo(id: "discoverPageYellow", type: DiscoverPageYellow.self)]
    }

    override open func configureViewCell(viewCell: UICollectionViewCell) -> UICollectionViewCell {

        return viewCell
    }
}

