//
//  FeedTableViewController.swift
//  InstaProject
//
//  Created by Anton Voropaiev on 9/18/19.
//  Copyright © 2019 Pavel Taran. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController {
    
    var postsArray = [Post]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        postRequest()
    }
    
    func configureTableView() {
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.reuseID())
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.allowsSelection = false
    }
    
    func postRequest() {
        JSONService.fetchPosts(success: { (postList) in
            self.postsArray = postList.posts
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseID(), for: indexPath) as! PostCell
        cell.render(viewModel: PostCell.PostViewModel.Factory.make(post: postsArray[indexPath.row]))
        return cell
    }
}
