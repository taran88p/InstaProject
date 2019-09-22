//
//  PostCell.swift
//  InstaProject
//
//  Created by Anton Voropaiev on 9/18/19.
//  Copyright © 2019 Pavel Taran. All rights reserved.
//

import UIKit
import SnapKit

class PostCell: UITableViewCell {
    
    var postHeaderView: PostHeaderView!
    var postMiddleView: PostMiddleView!
    var postFooterView: PostFooterView!
    var stackView: UIStackView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureLayouts()
    }
    
    private func configureViews() {
        postHeaderView = PostHeaderView()
        postMiddleView = PostMiddleView()
        postFooterView = PostFooterView()
        
        stackView = UIStackView(arrangedSubviews: [postHeaderView, postMiddleView, postFooterView])
        stackView.axis = .vertical
        stackView.alignment = .center
        addSubview(stackView)
    }
    
    private func configureLayouts() {
        stackView.snp.makeConstraints { make in
            make.top.right.bottom.left.equalToSuperview()
        }
        
        postHeaderView.snp.makeConstraints { make in
            make.top.right.left.equalToSuperview()
            make.height.equalTo(46)
        }
        
        postMiddleView.snp.makeConstraints { make in
            make.top.equalTo(postHeaderView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(450)
        }
        
        postFooterView.snp.makeConstraints { make in
            make.top.equalTo(postMiddleView.snp.bottom)
            make.left.right.equalToSuperview()
        }
        
    }
    
    func render(viewModel: PostViewModel) {
        postHeaderView.render(viewModel: viewModel.headerViewModel)
        postMiddleView.render(viewModel: viewModel.middelViewModel)
        postFooterView.render(viewModel: viewModel.footerViewModel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func reuseID() -> String {
        return NSStringFromClass(PostCell.self).components(separatedBy: ".").last!
    }
}

extension PostCell {
    struct PostViewModel {
        let headerViewModel: PostHeaderView.ViewModel
        let middelViewModel: PostMiddleView.ViewModel
        let footerViewModel: PostFooterView.ViewModel
        
        enum Factory {
            static func make(post: Post) -> PostViewModel {
                let userIcon = UIImage(named: post.userIcon)
                let headerViewModel = PostHeaderView.ViewModel(userName: post.userName,
                                                              location: post.location,
                                                              userIcon: userIcon ?? UIImage())
                
                let images = post.images.map { UIImage(named: $0) ?? UIImage() }
                
                let middleViewModel = PostMiddleView.ViewModel(images: images)
                let footerViewModel = PostFooterView.ViewModel(likes: post.likes,
                                                               comments: post.comments,
                                                               time: post.time)
                return .init(headerViewModel: headerViewModel,
                             middelViewModel: middleViewModel,
                             footerViewModel: footerViewModel)
            }
        }
    }
}
