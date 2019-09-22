//
//  Post.swift
//  InstaProject
//
//  Created by Anton Voropaiev on 9/18/19.
//  Copyright © 2019 Pavel Taran. All rights reserved.
//

import Foundation
import UIKit

struct Post: Codable {
    let userName: String
    let location: String
    let userIcon: String
    let images: [String]
    let likes: [String]
    let comments: [Comment]
    let time: String
}

struct Comment: Codable {
    let name: String
    let text: String
    var value: String {
        let attrs = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        let boldString = NSMutableAttributedString(string: name, attributes: attrs)
        return [boldString.string, text].joined(separator: " ")
    }
}

struct  PostsList: Codable {
    let posts: [Post]
}
