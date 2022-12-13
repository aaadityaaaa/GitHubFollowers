//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by Aaditya Singh on 10/12/22.
//

import UIKit


class GFRepoItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoOne.set(itemInfoType: .repos, with: user.publicRepos)
        itemInfoTwo.set(itemInfoType: .gists, with: user.publicGists)
        actionButton.set(backGroundColor: .systemTeal, title: "Github Profile")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGithubButton(for: user)
    }
    
}
