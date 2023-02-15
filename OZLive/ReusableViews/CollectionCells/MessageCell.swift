//
//  MessageCell.swift
//  OZLive
//
//  Created by Olijujuan Green on 2/8/23.
//

import UIKit
import Firebase

class MessageCell: UITableViewCell {
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    func setupViews() {
        [usernameLabel, messageLabel].forEach { self.contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
        
            usernameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constraints.widePadding.rawValue),
            usernameLabel.widthAnchor.constraint(equalToConstant: Constraints.usernameLabelWidth.rawValue),
            
            messageLabel.leadingAnchor.constraint(equalTo: usernameLabel.trailingAnchor, constant: Constraints.widePadding.rawValue),
            messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            messageLabel.topAnchor.constraint(equalTo: usernameLabel.topAnchor),
            
            contentView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor)
        ])
    }
    
    func setMessage(message: Message) {
        usernameLabel.text = message.senderID
        messageLabel.text = message.contents
    }
    
}

