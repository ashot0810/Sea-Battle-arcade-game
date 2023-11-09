//
//  PlayerCellForBattleViewController.swift
//  Sea Battle
//
//  Created by Ashot Hovhannisyan on 26.09.23.
//

import UIKit

final class PlayerCellForBattleViewController: UICollectionViewCell {
    
    private let playerIcon:UIImageView = {
        let imageView = UIImageView()
        imageView.image = DataAboutPlayerSingleton.shared.providePlayerIcon()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let opponentIcon:UIImageView = {
        let imageView = UIImageView()
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
    
    private let opponentNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.minimumScaleFactor = 0.2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let playerScoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Scores:"
        label.minimumScaleFactor = 0.2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let oponentScoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Scores:"
        label.minimumScaleFactor = 0.2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let playerIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let opponentIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(playerIcon)
        self.addSubview(playerNameLabel)
        self.addSubview(opponentIcon)
        self.addSubview(opponentNameLabel)
        self.addSubview(timerLabel)
        self.addSubview(playerScoreLabel)
        self.addSubview(oponentScoreLabel)
        self.addSubview(playerIndicator)
        self.addSubview(opponentIndicator)
        
        NSLayoutConstraint.activate([
            playerIcon.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 10),
            playerIcon.topAnchor.constraint(equalTo: self.topAnchor),
            playerIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            playerIcon.widthAnchor.constraint(equalToConstant: 150),
            playerNameLabel.leftAnchor.constraint(equalTo: self.playerIcon.leftAnchor,constant: 7),
            playerNameLabel.rightAnchor.constraint(equalTo: self.playerIcon.rightAnchor,constant: -4),
            playerNameLabel.bottomAnchor.constraint(equalTo: playerIcon.bottomAnchor,constant: -3),
            timerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            opponentIcon.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -10),
            opponentIcon.topAnchor.constraint(equalTo: self.topAnchor),
            opponentIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            opponentIcon.widthAnchor.constraint(equalToConstant: 150),
            playerNameLabel.leftAnchor.constraint(equalTo: self.playerIcon.leftAnchor,constant: 7),
            playerNameLabel.rightAnchor.constraint(equalTo: self.playerIcon.rightAnchor,constant: -4),
            playerNameLabel.bottomAnchor.constraint(equalTo: playerIcon.bottomAnchor,constant: -3),
            opponentNameLabel.leftAnchor.constraint(equalTo: self.opponentIcon.leftAnchor,constant: 7),
            opponentNameLabel.rightAnchor.constraint(equalTo: self.opponentIcon.rightAnchor,constant: -4),
            opponentNameLabel.bottomAnchor.constraint(equalTo: opponentIcon.bottomAnchor,constant: -3),
            playerScoreLabel.leftAnchor.constraint(equalTo: playerIcon.leftAnchor),
            playerScoreLabel.topAnchor.constraint(equalTo: playerIcon.topAnchor),
            oponentScoreLabel.leftAnchor.constraint(equalTo: opponentIcon.leftAnchor),
            oponentScoreLabel.topAnchor.constraint(equalTo: playerIcon.topAnchor),
            playerIndicator.topAnchor.constraint(equalTo: self.playerIcon.topAnchor),
            playerIndicator.rightAnchor.constraint(equalTo: self.playerIcon.rightAnchor),
            opponentIndicator.topAnchor.constraint(equalTo: self.opponentIcon.topAnchor),
            opponentIndicator.rightAnchor.constraint(equalTo: self.opponentIcon.rightAnchor),
            playerIndicator.heightAnchor.constraint(equalToConstant: 20),
            playerIndicator.widthAnchor.constraint(equalToConstant: 20),
            opponentIndicator.heightAnchor.constraint(equalToConstant: 20),
            opponentIndicator.widthAnchor.constraint(equalToConstant: 20),
        ])
        
        self.playerIndicator.layer.cornerRadius = 10
        self.opponentIndicator.layer.cornerRadius = 10

    }
    
    required init?(coder:NSCoder) {
        super.init(coder: coder)
       
        self.addSubview(playerIcon)
        self.addSubview(playerNameLabel)
        self.addSubview(opponentIcon)
        self.addSubview(opponentNameLabel)
        self.playerIcon.addSubview(playerIndicator)
        self.opponentIcon.addSubview(opponentIndicator)
        
        NSLayoutConstraint.activate([
            playerIcon.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 10),
            playerIcon.topAnchor.constraint(equalTo: self.topAnchor),
            playerIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            playerIcon.widthAnchor.constraint(equalToConstant: 150),
            playerNameLabel.leftAnchor.constraint(equalTo: self.playerIcon.leftAnchor,constant: 7),
            playerNameLabel.rightAnchor.constraint(equalTo: self.playerIcon.rightAnchor,constant: -4),
            playerNameLabel.bottomAnchor.constraint(equalTo: playerIcon.bottomAnchor,constant: -3),
            opponentIcon.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -10),
            opponentIcon.topAnchor.constraint(equalTo: self.topAnchor),
            opponentIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            opponentIcon.widthAnchor.constraint(equalToConstant: 150),
            playerNameLabel.leftAnchor.constraint(equalTo: self.playerIcon.leftAnchor,constant: 7),
            playerNameLabel.rightAnchor.constraint(equalTo: self.playerIcon.rightAnchor,constant: -4),
            playerNameLabel.bottomAnchor.constraint(equalTo: playerIcon.bottomAnchor,constant: -3),
            opponentNameLabel.leftAnchor.constraint(equalTo: self.opponentIcon.leftAnchor,constant: 7),
            opponentNameLabel.rightAnchor.constraint(equalTo: self.opponentIcon.rightAnchor,constant: -4),
            opponentNameLabel.bottomAnchor.constraint(equalTo: opponentIcon.bottomAnchor,constant: -3),
            playerScoreLabel.leftAnchor.constraint(equalTo: playerIcon.leftAnchor),
            playerScoreLabel.topAnchor.constraint(equalTo: playerIcon.topAnchor),
            oponentScoreLabel.leftAnchor.constraint(equalTo: opponentIcon.leftAnchor),
            oponentScoreLabel.topAnchor.constraint(equalTo: playerIcon.topAnchor),
            playerIndicator.topAnchor.constraint(equalTo: self.playerIcon.topAnchor),
            playerIndicator.rightAnchor.constraint(equalTo: self.playerIcon.rightAnchor),
            opponentIndicator.topAnchor.constraint(equalTo: self.opponentIcon.topAnchor),
            opponentIndicator.rightAnchor.constraint(equalTo: self.opponentIcon.leftAnchor),
        ])
        
        self.playerIndicator.layer.cornerRadius = 10
        self.opponentIndicator.layer.cornerRadius = 10
    }
    
    func configuire(name: String, icon: Data) {
        self.opponentNameLabel.text = name
        self.opponentIcon.image = UIImage(data: icon)
    }
    
    func updateTimerValue(with value: String) {
        self.timerLabel.text = value
    }
    
    func resetTimerView() {
        self.timerLabel.text = ""
    }
    
    func setPlayerScore(with score: Int) {
        self.playerScoreLabel.text = "Scores: \(score)"
    }
    
    func setOpponentScore(with score: Int) {
        self.oponentScoreLabel.text = "Scores: \(score)"
    }
    
    func enablePlayerIndicator() {
        self.playerIndicator.backgroundColor = .green.withAlphaComponent(0.7)
    }
    
    func enableOpponentIndicator() {
        self.opponentIndicator.backgroundColor = .green.withAlphaComponent(0.7)
    }
    
    func desablePlayerIndicator() {
        self.playerIndicator.backgroundColor = .clear
    }
    
    func desableOpponentIndicator() {
        self.opponentIndicator.backgroundColor = .clear
    }
    
    func hideTimerView() {
        self.timerLabel.alpha = 0
    }
}
