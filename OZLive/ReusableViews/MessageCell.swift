//
//  MessageCell.swift
//  OZLive
//
//  Created by Olijujuan Green on 2/8/23.
//

import UIKit
import Firebase
//
//class MessageCell: UITableViewCell {
//    let user = Auth.auth().currentUser
//
//    let usernameLabel: UILabel = {
//        let label = UILabel()
//        label.text = user.uid
//        return
//    }()
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//         super.init(style: style, reuseIdentifier: reuseIdentifier)
//    }
//
//}
class MessageCell: UITableViewCell {
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(usernameLabel)
        addSubview(messageLabel)
        
        usernameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        
        messageLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

