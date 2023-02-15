//
//  MovieDetailView.swift
//  OZLive
//
//  Created by Olijujuan Green on 2/14/23.
//

import UIKit

class MovieDetailView: UIView {
    
    let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Avengers: Endgame"
        label.font = .boldSystemFont(ofSize: Constraints.movieTitleLabelHeight.rawValue)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let releaseYearLabel: UILabel = {
        let label = UILabel()
        label.text = "2019"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "TV-14"
        label.backgroundColor = .systemFill
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let inviteButton: UIButton = {
        let button = UIButton()
        let img = UIImage(systemName: "person.badge.plus")
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.setTitle("Invite", for: .normal)
        button.addTarget(self, action: #selector(handleInvite), for: .touchUpInside)
        button.setImage(img, for: .normal)
        button.imageView?.contentMode = .scaleToFill
        button.layer.cornerRadius = 14
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    @objc func handleInvite() {
        print("Invite Button Pressed")
    }
    
    let castLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.text = "Cast"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let castCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    func setupViews() {
        [movieTitleLabel, releaseYearLabel, ratingLabel, descriptionLabel, inviteButton, castLabel, castCollectionView].forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            movieTitleLabel.topAnchor.constraint(equalTo: topAnchor),
            movieTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            releaseYearLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: Constraints.narrowPadding.rawValue),
            releaseYearLabel.leadingAnchor.constraint(equalTo: movieTitleLabel.leadingAnchor, constant: Constraints.narrowPadding.rawValue),
            
            ratingLabel.topAnchor.constraint(equalTo: releaseYearLabel.topAnchor),
            ratingLabel.leadingAnchor.constraint(equalTo: releaseYearLabel.trailingAnchor, constant: Constraints.widePadding.rawValue),
            
            descriptionLabel.topAnchor.constraint(equalTo: releaseYearLabel.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: releaseYearLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            inviteButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Constraints.standardVerticalSpacing.rawValue),
            inviteButton.leadingAnchor.constraint(equalTo: releaseYearLabel.leadingAnchor),
            inviteButton.widthAnchor.constraint(equalToConstant: 80),
            inviteButton.heightAnchor.constraint(equalToConstant: 30),
            
            castLabel.topAnchor.constraint(equalTo: inviteButton.bottomAnchor, constant: Constraints.narrowPadding.rawValue),
            castLabel.leadingAnchor.constraint(equalTo: inviteButton.leadingAnchor),
            
            castCollectionView.topAnchor.constraint(equalTo: castLabel.bottomAnchor),
            castCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            castCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            castCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
            
        ])
    }
    
    func configureCollectionView() {
        castCollectionView.delegate = self
        castCollectionView.dataSource = self
        castCollectionView.register(CastCell.self, forCellWithReuseIdentifier: "cellId")
    }
    
}





extension MovieDetailView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CastCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
}
