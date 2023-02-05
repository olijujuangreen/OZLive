//
//  SettingsVC.swift
//  OZLive
//
//  Created by Joey Rubin on 1/26/23.
//

import UIKit

class SettingsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let settingsTableView = UITableView()
    
    enum Settings: String, CaseIterable {
        case Settings_1, Settings_2, Settings_3, Settings_4,
        Settings_5, Settings_6, Settings_7, Settings_8, Settings_9
        
// Eventually we will have settings and specific alerts to switch on here:
//        var alert: String {
//                   switch self {
//                   case .Settings_1:
//                       return "UIAlert with object to adjust"
    }
    
    var settingsArray = Settings.allCases.map({$0.rawValue.replacingOccurrences(of: "_", with: " ")})
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        settingsTableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reusidentifier)
        view.addSubview(settingsTableView)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settingsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reusidentifier, for: indexPath) as! SettingsCell
        cell.settingsCellLabel.text = settingsArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SettingsCell
        let labelText = cell.settingsCellLabel.text
        print(labelText)
        changeSettings()
    }
    
    func changeSettings() {
        let alert = UIAlertController(title: "Select an option", message: "\n\n\n\n", preferredStyle: .alert)
        
        //Setting up alert witth toggles for now as place holders. In the future it could be UIPickers, or other objects that make sense according to what the setting adjustment will be.
        let toggle = UISwitch()
        alert.view.addSubview(toggle)
        
        toggle.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = NSLayoutConstraint(item: toggle, attribute: .centerX, relatedBy: .equal, toItem: alert.view, attribute: .centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: toggle, attribute: .bottom, relatedBy: .equal, toItem: alert.view, attribute: .bottom, multiplier: 1, constant: -80)

        alert.view.addConstraints([horizontalConstraint, verticalConstraint])
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            // do something with the selected option
        }
        alert.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        
    }
}
