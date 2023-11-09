//
//  GameResultsTableViewCell.swift
//  Sea Battle
//
//  Created by Ashot Hovhannisyan on 11.10.23.
//

import UIKit

final class GameResultsTableViewCell: UITableViewCell {
    
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
        label.font = .boldSystemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.minimumScaleFactor = 0.2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let opponentNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.minimumScaleFactor = 0.2
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
    
    private let gameStateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 35)
        label.minimumScaleFactor = 0.2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func configuire(playerName: String, playerScores: Int,playerImage:Data, opponentName:String ,opponentScores: Int, opponentImage: Data, gamingState: Bool) {
        
        self.backgroundColor = .cyan.withAlphaComponent(0.2)
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.layer.borderColor = .init(gray: 10000, alpha: 0.3)
        self.layer.borderWidth = 5
        
        if gamingState {
            self.gameStateLabel.text = "Win"
        } else {
            self.gameStateLabel.text = "Lose"
        }
        
        self.playerNameLabel.text = playerName
        self.playerScoreLabel.text = "Scores: \(playerScores)"
        self.playerIcon.image = UIImage(data: playerImage)
        self.opponentNameLabel.text = opponentName
        self.opponentIcon.image = UIImage(data: opponentImage)
        self.oponentScoreLabel.text = "Scores: \(opponentScores)"
        
        self.contentView.addSubview(self.playerIcon)
        self.contentView.addSubview(self.opponentIcon)
        self.contentView.addSubview(self.playerNameLabel)
        self.contentView.addSubview(self.opponentNameLabel)
        self.contentView.addSubview(self.playerScoreLabel)
        self.contentView.addSubview(self.oponentScoreLabel)
        self.contentView.addSubview(self.gameStateLabel)
        
        NSLayoutConstraint.activate([
            self.gameStateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.gameStateLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 5),
            self.playerIcon.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,constant: 15),
            self.playerIcon.topAnchor.constraint(equalTo: self.gameStateLabel.bottomAnchor,constant: 5),
            self.playerIcon.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.5),
            self.playerIcon.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.4),
            self.opponentIcon.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,constant: -15),
            self.opponentIcon.topAnchor.constraint(equalTo: self.gameStateLabel.bottomAnchor,constant: 5),
            self.opponentIcon.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.5),
            self.opponentIcon.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.4),
            self.playerNameLabel.centerXAnchor.constraint(equalTo: self.playerIcon.centerXAnchor),
            self.playerNameLabel.topAnchor.constraint(equalTo: self.playerIcon.bottomAnchor,constant: 5),
            self.playerScoreLabel.centerXAnchor.constraint(equalTo: self.playerIcon.centerXAnchor),
            self.playerScoreLabel.topAnchor.constraint(equalTo: self.playerNameLabel.bottomAnchor,constant: 5),
            self.opponentNameLabel.centerXAnchor.constraint(equalTo: self.opponentIcon.centerXAnchor),
            self.opponentNameLabel.topAnchor.constraint(equalTo: self.opponentIcon.bottomAnchor,constant: 5),
            self.oponentScoreLabel.centerXAnchor.constraint(equalTo: self.opponentIcon.centerXAnchor),
            self.oponentScoreLabel.topAnchor.constraint(equalTo: self.opponentNameLabel.bottomAnchor,constant: 5),
            
        ])
    }
}
