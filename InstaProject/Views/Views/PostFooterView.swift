//
//  PostFooterView.swift
//  InstaProject
//
//  Created by Anton Voropaiev on 9/18/19.
//  Copyright © 2019 Pavel Taran. All rights reserved.
//

import UIKit

class PostFooterView: UIView {
    
    var likes: UILabel!
    var comments: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        configureLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        likes = UILabel()
        addSubview(likes)
        likes.font = UIFont.boldSystemFont(ofSize: 13.0)
        likes.numberOfLines = 2
        
        comments = UILabel()
        addSubview(comments)
        comments.font = UIFont.systemFont(ofSize: 13.0)
        comments.numberOfLines = 0
    }
    
    private func configureLayouts() {
        likes.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(10)
            make.right.equalTo(-10)
        }
        
        comments.snp.makeConstraints { make in
            make.top.equalTo(likes.snp.bottom).offset(5)
            make.left.equalTo(10)
            make.right.equalTo(0)
            make.bottom.equalToSuperview()
        }
    }
}

extension PostFooterView {
    func render(viewModel: ViewModel) {
        likes.text = createLikes(array: viewModel.likes)
        comments.text = viewModel.comments.map { $0.value }.joined(separator: "\n")
    }
    
    func createLikes(array: [String]) -> String {
        if !array.isEmpty {
            let names = array[0...2].joined(separator: ",")
            return "Liked by \(names) \nand \(array[3..<array.count].count) others"
        }
        return ""
    }
}

extension PostFooterView {
    struct ViewModel {
        let likes: [String]
        let comments: [Comment]
        let time: String
    }
}
