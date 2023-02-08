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
    var player = AVPlayer()
    var messages = [Message]()
    let user = Auth.auth().currentUser
    
    let ref = Database.database().reference()
    
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
        retrieveMessages { [weak self] message in
            guard let self = self else { return }
            self.messages.append(message)
            self.chatTableView.reloadData()
        }
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
        let movieURL = URL(string: Storage.movieURLString.rawValue)!
        
        player = AVPlayer(url: movieURL)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = moviePlayerView.bounds
        moviePlayerView.layer.addSublayer(playerLayer)
        
        player.play()
        
        let time = CMTime(seconds: 30, preferredTimescale: 1)
        let tolerance = CMTime(seconds: 5, preferredTimescale: 1)
        player.seek(to: time, toleranceBefore: tolerance, toleranceAfter: tolerance)

    }
    
    func sendMessage(senderID: String, message: String) {
        
        let messageRef = ref.child("movieMessages").childByAutoId()
        let messageData = ["senderId": senderID, "message": message]
        messageRef.setValue(messageData)
    }
    
    func retrieveMessages(completion: @escaping(Message) -> Void) {
        let messagesRef = ref.child("movieMessages")
        messagesRef.observe(.childAdded) { snapshot in
            let messageData = snapshot.value as! [String: String]
            if let senderID = messageData["senderID"], let contents = messageData["message"] {
                let message = Message(senderID: senderID, contents: contents)
                completion(message)
            }
        }
    }


}

extension MoviePlayerVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId")
        return cell!
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

struct Message {
    let senderID: String
    let contents: String
}
