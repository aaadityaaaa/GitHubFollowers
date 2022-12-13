//
//  FollowerCell.swift
//  GHFollowers
//
//  Created by Aaditya Singh on 09/12/22.
//

import UIKit
import SwiftUI


class FollowerCell: UICollectionViewCell {
    
    static let reuseCellId = "FollowerCell"
    let avatarImageView = GFImageView(frame: .zero)
    let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower) {
//        if #available(iOS 16.0, *) {
//            contentConfiguration = UIHostingConfiguration { FollowerView(follower: follower) }
//        }
//        else {
            titleLabel.text = follower.login
        NetworkManager.shared.downloadImageFromUrl(from: follower.avatarUrl) { [weak self] image in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.avatarImageView.image = image
            }
        }
      
    }
    
    
    private func configure() {
        
        addSubview(avatarImageView)
        addSubview(titleLabel)
        let padding: CGFloat = 8

        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            
            titleLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 20)
            
        ])
        
    }
}
