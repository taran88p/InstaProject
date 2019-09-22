//
//  PostMiddleView.swift
//  InstaProject
//
//  Created by Anton Voropaiev on 9/18/19.
//  Copyright © 2019 Pavel Taran. All rights reserved.
//

import UIKit
import SnapKit

class PostMiddleView: UIView {
    
    var viewModel = ViewModel.empty
    var collectionView: UICollectionView!
    var likeButton: UIButton!
    var bubbleButton: UIButton!
    var planeButton: UIButton!
    var pageControl: UIPageControl!
    var bookMarkButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        configureLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        let flowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.register(ImageCollectionCell.self, forCellWithReuseIdentifier: ImageCollectionCell.reuseID())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        flowLayout.scrollDirection = .horizontal
        collectionView.backgroundColor = .white
        addSubview(collectionView)
        
        likeButton = UIButton(frame: CGRect.zero)
        likeButton.setImage(UIImage(named: Constans.likeImageName), for: .normal)
        addSubview(likeButton)
        
        bubbleButton = UIButton(frame: CGRect.zero)
        bubbleButton.setImage(UIImage(named: Constans.bubbleImageName), for: .normal)
        addSubview(bubbleButton)
        
        planeButton = UIButton(frame: CGRect.zero)
        planeButton.setImage(UIImage(named: Constans.planeImageName), for: .normal)
        addSubview(planeButton)
        
        pageControl = UIPageControl(frame: CGRect.zero)
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        addSubview(pageControl)
        
        bookMarkButton = UIButton(frame: CGRect.zero)
        bookMarkButton.setImage(UIImage(named: Constans.bookMarkImageName), for: .normal)
        addSubview(bookMarkButton)
    }
    
    private func configureLayouts() {
        collectionView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-40)
        }
        
        likeButton.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(collectionView.snp.bottom).offset(10)
            make.height.width.equalTo(25)
        }
        
        bubbleButton.snp.makeConstraints { make in
            make.left.equalTo(likeButton.snp.right).offset(15)
            make.centerY.equalTo(likeButton.snp.centerY)
            make.height.width.equalTo(25)
        }
        
        planeButton.snp.makeConstraints { make in
            make.left.equalTo(bubbleButton.snp.right).offset(15)
            make.centerY.equalTo(bubbleButton.snp.centerY)
            make.height.width.equalTo(25)
        }
        
        pageControl.snp.makeConstraints { make in
            make.lastBaseline.equalTo(planeButton.snp.lastBaseline)
            make.centerX.equalToSuperview()
        }
        
        bookMarkButton.snp.makeConstraints { make in
            make.right.equalTo(-10)
            make.top.equalTo(collectionView.snp.bottom).offset(10)
            make.height.width.equalTo(25)
        }
    }
}

extension PostMiddleView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionCell.reuseID(), for: indexPath) as! ImageCollectionCell
        cell.render(with: viewModel.images[indexPath.row])
        return cell
    }
}

extension PostMiddleView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let width = scrollView.bounds.size.width
        let currentPage = Int(ceil(offsetX/width))
        pageControl.currentPage = currentPage
    }
}

extension PostMiddleView {
    func render(viewModel model: ViewModel) {
        viewModel = model

        pageControl.numberOfPages = model.images.count == 1 ? 0 : model.images.count
    }
}

extension PostMiddleView {
    
    struct ViewModel {
        static let empty = ViewModel(images: [])
        let images: [UIImage]
    }
}

extension PostMiddleView {
    enum Constans {
        static let likeImageName = "like"
        static let bubbleImageName = "bubble"
        static let planeImageName = "plane"
        static let bookMarkImageName = "bookmark"
    }
}
