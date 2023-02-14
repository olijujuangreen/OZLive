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
        label.text = "username"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "contents of the message"
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
        [usernameLabel, messageLabel].forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
        
            usernameLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constraints.standardVerticalSpacing.rawValue),
            usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constraints.widePadding.rawValue),
            usernameLabel.widthAnchor.constraint(equalToConstant: Constraints.usernameLabelWidth.rawValue),
            
            messageLabel.leadingAnchor.constraint(equalTo: usernameLabel.trailingAnchor, constant: Constraints.widePadding.rawValue),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            messageLabel.topAnchor.constraint(equalTo: topAnchor)
        
        ])
    }
    
    func setMessage(message: Message) {
        usernameLabel.text = message.senderID
        messageLabel.text = message.contents
    }
    
}

