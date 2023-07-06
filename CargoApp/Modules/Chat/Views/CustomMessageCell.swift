//
//  CustomMessageCell.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 06.07.23.
//

import UIKit

final class CustomMessageCell: UITableViewCell {
//    @IBOutlet var messageBackground: UIView!
//        @IBOutlet var avatarImageView: UIImageView!
//        @IBOutlet var messageBody: UILabel!
//        @IBOutlet var senderUsername: UILabel!
    
    lazy var messageBackground: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var avatarImageView: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    lazy var messageBody: UILabel = {
        let view = UILabel()
        
        return view
    }()
    
    lazy var senderUsername: UILabel = {
        let view = UILabel()
        
        return view
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(messageBackground)
        messageBackground.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        messageBackground.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.height.width.equalTo(50)
        }
        
        
    }
}
