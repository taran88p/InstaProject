//
//  PostHeaderView.swift
//  InstaProject
//
//  Created by Anton Voropaiev on 9/18/19.
//  Copyright © 2019 Pavel Taran. All rights reserved.
//

import UIKit

class PostHeaderView: UIView {
    
    var userIcon: UIImageView!
    var userName: UILabel!
    var location: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        configureLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func configureViews() {
        userIcon = UIImageView()
        addSubview(userIcon)
        userIcon.layer.cornerRadius = 19
        userIcon.layer.masksToBounds = true
        userIcon.contentMode = .scaleAspectFill
        
        userName = UILabel()
        addSubview(userName)
        userName.font = UIFont.boldSystemFont(ofSize: 13.0)
        
        location = UILabel()
        addSubview(location)
        location.font = UIFont.systemFont(ofSize: 13.0)
    }
    
    private func configureLayouts() {
        
        userIcon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(10)
            make.width.equalTo(38)
            make.height.equalTo(38)
        }
        
        userName.snp.makeConstraints { make in
            make.top.equalTo(5)
            make.left.equalTo(userIcon.snp.right).offset(10)
        }
        
        location.snp.makeConstraints { make in
            make.top.equalTo(userName.snp.bottom).offset(5)
            make.left.equalTo(userIcon.snp.right).offset(10)
        }
    }
}

extension PostHeaderView {
    func render(viewModel: ViewModel) {
        userIcon.image = viewModel.userIcon
        userName.text = viewModel.userName
        location.text = viewModel.location
    }
}

extension PostHeaderView {
    struct ViewModel {
        let userName: String
        let location: String
        let userIcon: UIImage
    }
}
