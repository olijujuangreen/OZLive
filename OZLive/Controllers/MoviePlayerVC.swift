//
//  MoviePlayerVC.swift
//  OZLive
//
//  Created by Olijujuan Green on 1/26/23.
//

import UIKit
import AVFoundation
import Firebase

class MoviePlayerVC: UIViewController {
    let featuredMovieRef = Database.database().reference(fromURL: Storage.referenceURLString.rawValue).child("featureMovie")
    
    var player = AVPlayer()
    var messages = [Message]()
    let user = Auth.auth().currentUser
    
    let moviePlayerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var dismissButton: UIButton = {
        let btn = UIButton()
        let img = UIImage(systemName: "x.circle.fill")
        btn.tintColor = .white
        btn.setImage(img, for: .normal)
        btn.addTarget(self, action: #selector(dismissButtonPressed), for: .touchUpInside)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    @objc func dismissButtonPressed() {
        player.pause()
        self.dismiss(animated: true)
    }
    
    let chatTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    let chatTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter Mesasge ..."
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        chatTextField.delegate = self
        setupTableView()
        observeMessages()
    }
    
    
    
    
    
    
    
    func setupViews() {
        let moviePlayerHeight = (view.frame.width * 1080) / 1920
        [moviePlayerView, chatTableView, chatTextField].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
        
            moviePlayerView.topAnchor.constraint(equalTo: view.topAnchor),
            moviePlayerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moviePlayerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moviePlayerView.heightAnchor.constraint(equalToConstant: moviePlayerHeight),
            
            chatTableView.topAnchor.constraint(equalTo: moviePlayerView.bottomAnchor),
            chatTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chatTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chatTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constraints.largeVerticalSpacing.rawValue * 2),
            
            chatTextField.topAnchor.constraint(equalTo: chatTableView.bottomAnchor),
            chatTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chatTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chatTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
        ])
        
        self.view.layoutIfNeeded()
//        setupPlayer()
        moviePlayerView.addSubview(dismissButton)
        dismissButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
    }
    
    func setupPlayer() {
        let movieURL = URL(string: Storage.avengersURLString.rawValue)!
        
        player = AVPlayer(url: movieURL)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = moviePlayerView.bounds
        moviePlayerView.layer.addSublayer(playerLayer)
        
        player.play()
        
        let time = CMTime(seconds: 30, preferredTimescale: 1)
        let tolerance = CMTime(seconds: 5, preferredTimescale: 1)
        player.seek(to: time, toleranceBefore: tolerance, toleranceAfter: tolerance)

    }
    
    func setupTableView() {
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.register(MessageCell.self, forCellReuseIdentifier: ReuseIds.messageCell.rawValue)
//        chatTableView.register(UITableViewCell.self, forCellReuseIdentifier: "messageCell")
    }
    
    func sendMessage(senderID: String, message: String) {
        let messageRef = featuredMovieRef.child("messages").childByAutoId()
        let messageData = ["senderId": senderID, "message": message]
        messageRef.setValue(messageData)
    }
    
    func observeMessages() {
        let messagesRef = featuredMovieRef.child("messages")
        
        messagesRef.observe(.childAdded) { snapshot in
            guard let messageData = snapshot.value as? [String: Any],
                  let senderID = messageData["senderId"] as? String,
                  let contents = messageData["message"] as? String else {
                return
            }
            
            let message = Message(senderID: senderID, contents: contents)
            self.messages.append(message)
            
            DispatchQueue.main.async {
                self.chatTableView.reloadData()
                self.chatTableView.scrollToRow(at: IndexPath(row: self.messages.count - 1, section: 0), at: .bottom, animated: true)
            }
            
        }
        
        
    }


}

extension MoviePlayerVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIds.messageCell.rawValue, for: indexPath) as! MessageCell
        let message = messages[indexPath.row]
        cell.setMessage(message: message)
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = .systemFill
        } else {
            cell.backgroundColor = .systemBackground
        }
        return cell
    }


}

extension MoviePlayerVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let message = textField.text!
        sendMessage(senderID: user!.uid, message: message)
        textField.text = ""
        textField.resignFirstResponder()
        return true
    }
}

