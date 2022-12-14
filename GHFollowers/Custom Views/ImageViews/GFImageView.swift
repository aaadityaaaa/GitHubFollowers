//
//  GFImageView.swift
//  GHFollowers
//
//  Created by Aaditya Singh on 09/12/22.
//

import UIKit

class GFImageView: UIImageView {
    
    let cache = NetworkManager.shared.cache
    
    let placeHolderImage = UIImage(named: "avatar-placeholder")!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds      = true
        image              = placeHolderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    
    
    

}
