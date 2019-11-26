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
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .yellow
        iv.image = UIImage(named: "Dome")
        iv.clipsToBounds = true //fix the flicker
        return iv
    }()

    func setupViews(){
        backgroundColor = .blue
        addSubview(imageView)
        imageView.anchorToView(view: self)
    }
    
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
}
