//
//  ImageCollectionCell.swift
//  InstaProject
//
//  Created by Anton Voropaiev on 9/18/19.
//  Copyright © 2019 Pavel Taran. All rights reserved.
//

import UIKit
import SnapKit

class ImageCollectionCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        configureLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render(with image: UIImage) {
        imageView.image = image
    }
    
    private func configureViews() {
       imageView = UIImageView()
       addSubview(imageView)
    }
    
    private func configureLayouts() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    class func reuseID() -> String {
        return NSStringFromClass(ImageCollectionCell.self).components(separatedBy: ".").last!
    }
}
