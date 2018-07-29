//
//  PhotoSelectorCell.swift
//  InstagramFirebase
//
//  Created by anantawasthy on 29/07/18.
//  Copyright © 2018 anantawasthy. All rights reserved.
//

import UIKit

class PhotoSelectorCell: UICollectionViewCell {
    
    let image : UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = UIColor.brown
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(image)
        
        image.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        image.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        image.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
