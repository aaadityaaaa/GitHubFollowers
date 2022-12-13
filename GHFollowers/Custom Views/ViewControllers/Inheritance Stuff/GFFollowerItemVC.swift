//
//  GFFollowerItemVC.swift
//  GHFollowers
//
//  Created by Aaditya Singh on 10/12/22.
//


import UIKit


class GFFollowerItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoOne.set(itemInfoType: .followers, with: user.followers)
        itemInfoTwo.set(itemInfoType: .following, with: user.following)
        actionButton.set(backGroundColor: .systemBrown, title: "Get Followers")
    }
    
    override func actionButtonTapped() {
        delegate.didTapUserFollowers(for: user)
    }
    
    
}

