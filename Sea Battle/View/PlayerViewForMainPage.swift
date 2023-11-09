//
//  PlayerViewForMainPage.swift
//  Sea Battle
//
//  Created by Ashot Hovhannisyan on 13.10.23.
//

import UIKit

@objc protocol TapToOpenPhotosLibraryGestureTargetSetter {
    @objc func tapToOpenPhotosLibraryGestureSelector(_ sender: UITapGestureRecognizer)
}

final class PlayerViewForMainPage: UIView {
    private let playerIcon:UIImageView = {
        let imageView = UIImageView()
        imageView.image = DataAboutPlayerSingleton.shared.providePlayerIcon()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let playerNameLabel: UILabel = {
        let label = UILabel()
        label.text = DataAboutPlayerSingleton.shared.providePlayerName()
        label.font = .boldSystemFont(ofSize: 25)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.minimumScaleFactor = 0.2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Tap to change icon"
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.minimumScaleFactor = 0.2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tapToOpenPhotosLibrary: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        return gesture
    }()
    
    func configure() {
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        self.backgroundColor = .cyan.withAlphaComponent(0.1)
        
        self.addSubview(self.playerIcon)
        self.addSubview(self.playerNameLabel)
        self.addSubview(self.messageLabel)
        
        self.playerIcon.addGestureRecognizer(self.tapToOpenPhotosLibrary)
        
        self.playerIcon.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            playerNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            playerNameLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 5),
            playerIcon.topAnchor.constraint(equalTo: self.playerNameLabel.bottomAnchor,constant: 5),
            playerIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            playerIcon.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            playerIcon.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7),
            messageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            messageLabel.topAnchor.constraint(equalTo: self.playerIcon.bottomAnchor,constant: 3)
        ])
    }
    
    func setGesturesTarget(target: TapToOpenPhotosLibraryGestureTargetSetter) {
        self.tapToOpenPhotosLibrary.addTarget(target, action: #selector(target.tapToOpenPhotosLibraryGestureSelector))
    }
    
    func setPlayerImage(with image: UIImage?) {
        DispatchQueue.main.async(qos: .userInteractive) {
            self.playerIcon.image = image
        }
    }
    
    func desableGestureRecognizer() {
        self.playerIcon.removeGestureRecognizer(self.tapToOpenPhotosLibrary)
    }
    
    func resetPlayerNameAsMessage(with message: String) {
        self.messageLabel.text = ""
        self.playerNameLabel.text = message
    }
    
    func reload() {
        self.playerIcon.image = DataAboutPlayerSingleton.shared.providePlayerIcon()
        self.playerNameLabel.text = DataAboutPlayerSingleton.shared.providePlayerName()
    }
}
