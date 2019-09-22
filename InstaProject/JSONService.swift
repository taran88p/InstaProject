//
//  JSONService.swift
//  InstaProject
//
//  Created by Anton Voropaiev on 9/18/19.
//  Copyright © 2019 Pavel Taran. All rights reserved.
//

import Foundation

struct JSONService {
    
    typealias Success = (PostsList) -> Void
    typealias Failure = (Error) -> Void
    
    static func fetchPosts(success: @escaping Success, failure: @escaping Failure) {
        DispatchQueue.global(qos: .background).async {
            if let path = Bundle.main.url(forResource: "posts", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: path)
                    let list = try! JSONDecoder().decode(PostsList.self, from: data)
                    success(list)
                } catch let error {
                    failure(error)
                }
            }
        }
    }
}
