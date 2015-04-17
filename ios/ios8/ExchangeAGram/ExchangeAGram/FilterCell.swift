//
//  FilterCell.swift
//  ExchangeAGram
//
//  Created by Portia Dean on 4/17/15.
//  Copyright (c) 2015 Portia Dean. All rights reserved.
//

import UIKit

class FilterCell: UICollectionViewCell {
    
    let imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        contentView.addSubview(imageView)
    }
    
    // filter subclass nscoding compliant
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
