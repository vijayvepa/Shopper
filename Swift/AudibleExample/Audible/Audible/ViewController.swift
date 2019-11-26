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

    
    let cellId : String = "cellId"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(collectionView)
        
        collectionView.anchorToView(view: view)
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    //region Collection View Delegates
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    //endregion

}

extension UIView{
    
    func anchorToView(view: UIView){
        anchorToTop(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    func anchorToTop(top: NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil,
                     left: NSLayoutAnchor<NSLayoutXAxisAnchor>? = nil,
                     bottom: NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil,
                     right: NSLayoutAnchor<NSLayoutXAxisAnchor>? = nil) {
        
        anchorWithConstantsToTop(top: top, left: left, bottom: bottom, right:right, topConstant: 0, leftConstant:  0, bottomConstant:  0 , rightConstant: 0)
    }
    
    func anchorWithConstantsToTop(top: NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil,
                                  left: NSLayoutAnchor<NSLayoutXAxisAnchor>? = nil,
                                  bottom: NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil,
                                  right: NSLayoutAnchor<NSLayoutXAxisAnchor>? = nil,
                                  topConstant:CGFloat = 0,
                                  leftConstant: CGFloat =  0,
                                  bottomConstant: CGFloat = 0,
                                  rightConstant:CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: topConstant).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: leftConstant).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: bottomConstant).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: rightConstant).isActive = true
        }
        
    }
}
