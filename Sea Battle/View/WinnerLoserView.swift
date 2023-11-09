//
//  WinnerLoserView.swift
//  Sea Battle
//
//  Created by Ashot Hovhannisyan on 08.10.23.
//

import UIKit

@objc protocol MainPageConfiguirerToPop {
    @objc func handleMainButtonTap(_ sender: UIButton)
}

final class WinnerLoserView: UIView {
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "captain"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let winnerLoserLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black.withAlphaComponent(0.12)
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 53)
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 15
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let playerOpponentNameScoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .black.withAlphaComponent(0.12)
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 15
        label.minimumScaleFactor = 0.1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let backToMainButton: UIButton = {
        let button = UIButton()
        button.setTitle("Main", for: .normal)
        NSLayoutConstraint.activate([
            button.titleLabel!.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            button.titleLabel!.widthAnchor.constraint(equalTo: button.widthAnchor, multiplier: 0.7),
        ])
        button.layer.cornerRadius = 20
        button.backgroundColor = .blue.withAlphaComponent(0.1)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.addAction(UIAction(handler: { _ in
            playClickSound()
            UIView.animate(withDuration: 0.2) {
                button.backgroundColor = .white.withAlphaComponent(0.1)
                button.backgroundColor = .blue.withAlphaComponent(0.15)
            }
        }), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let thanksMessageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.minimumScaleFactor = 0.2
        label.text = "Thanks for relaxing with us"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        
        self.backToMainButton.titleLabel?.font = .boldSystemFont(ofSize: 40)

        self.addSubview(backgroundImageView)
        self.addSubview(winnerLoserLabel)
        self.addSubview(playerOpponentNameScoreLabel)
        self.addSubview(backToMainButton)
        self.addSubview(thanksMessageLabel)
        
        NSLayoutConstraint.activate([
            self.backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.backgroundImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.backgroundImageView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.winnerLoserLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.winnerLoserLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 4),
            self.winnerLoserLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -4),
            self.playerOpponentNameScoreLabel.topAnchor.constraint(equalTo: self.winnerLoserLabel.bottomAnchor, constant: 3),
            self.playerOpponentNameScoreLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.playerOpponentNameScoreLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 4),
            self.playerOpponentNameScoreLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -4),
            self.backToMainButton.topAnchor.constraint(equalTo: self.playerOpponentNameScoreLabel.bottomAnchor,constant: 5),
            self.backToMainButton.centerXAnchor.constraint(equalTo: self.winnerLoserLabel.centerXAnchor),
            self.thanksMessageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.thanksMessageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        
        self.backToMainButton.titleLabel?.font = .boldSystemFont(ofSize: 30)

        self.addSubview(backgroundImageView)
        self.addSubview(winnerLoserLabel)
        self.addSubview(playerOpponentNameScoreLabel)
        self.addSubview(backToMainButton)
        self.addSubview(thanksMessageLabel)
        
        NSLayoutConstraint.activate([
            self.backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.backgroundImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.backgroundImageView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.winnerLoserLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.winnerLoserLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 4),
            self.winnerLoserLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -4),
            self.playerOpponentNameScoreLabel.topAnchor.constraint(equalTo: self.winnerLoserLabel.bottomAnchor, constant: 3),
            self.playerOpponentNameScoreLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.playerOpponentNameScoreLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 4),
            self.playerOpponentNameScoreLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -4),
            self.backToMainButton.topAnchor.constraint(equalTo: self.playerOpponentNameScoreLabel.bottomAnchor,constant: 5),
            self.backToMainButton.centerXAnchor.constraint(equalTo: self.winnerLoserLabel.centerXAnchor),
            self.thanksMessageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.thanksMessageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3)
        ])
    }
 
    func setMessageText(with text: String) {
        self.winnerLoserLabel.text = text
    }
    
    func setPlayersWithScore(by text: String) {
        self.playerOpponentNameScoreLabel.text = text
    }
    
    func setButtonHandler(with handler: MainPageConfiguirerToPop) {
        self.backToMainButton.addTarget(handler, action: #selector(handler.handleMainButtonTap), for: .touchUpInside)
    }
    
    func hideMainButton() {
        self.backToMainButton.isHidden = true
    }
    
}
