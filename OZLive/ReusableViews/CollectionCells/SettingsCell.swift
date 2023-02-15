//
//  SettingsCell.swift
//  OZLive
//
//  Created by Joey Rubin on 1/26/23.
//

import UIKit

class SettingsCell: UITableViewCell {

    static let reusidentifier = String(describing: SettingsCell.self)
    let settingsCellLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        settingsCellLabel.frame = CGRect(x: 5, y: 0, width: self.frame.width, height: self.frame.height)
        settingsCellLabel.font = UIFont.systemFont(ofSize: 16)
        settingsCellLabel.textColor = .black
        settingsCellLabel.textAlignment = .left
        self.contentView.addSubview(settingsCellLabel)
     }
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
