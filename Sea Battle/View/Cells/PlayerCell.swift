//
//  PlayerCell.swift
//  Sea Battle
//
//  Created by Ashot Hovhannisyan on 19.09.23.
//

import UIKit

@objc protocol AutoButtonTargetSetter {
    @objc func getRandomAddedMap()
}

@objc protocol StartButtonTargetSetter {
    @objc func startBattleButtonTapSelector(_ sender: UIButton)
}

@objc protocol JoinButtonTargetSetter {
    @objc func joinBattleButtonTapSelector(_ sender: UIButton)
}

@objc protocol SaveButtonTargetSetter {
    @objc func saveBattleButtonTapSelector()
}

@objc protocol BackButtonTargetSetter {
    @objc func backBattleButtonTapSelector(_ sender: UIButton)
}

final class PlayerCell: UICollectionViewCell {
    
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
    
    private let startBattleButton:UIButton = {
        let button = UIButton()
        button.setTitle("Start Battle!", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.titleLabel?.minimumScaleFactor = 0.5
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.backgroundColor = .purple.withAlphaComponent(0.3)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.titleLabel!.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            button.titleLabel!.widthAnchor.constraint(equalTo: button.widthAnchor, multiplier: 0.7)
        ])
        button.addAction(UIAction(handler: { _ in
            playClickSound()
            UIView.animate(withDuration: 0.2) {
                button.backgroundColor = .white.withAlphaComponent(0.1)
                button.backgroundColor = .purple.withAlphaComponent(0.3)
            }
        }), for: .touchUpInside)
        return button
    }()
    
    private let joinBattleButton:UIButton = {
        let button = UIButton()
        button.setTitle("Join To Battle!", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.titleLabel?.minimumScaleFactor = 0.5
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.backgroundColor = .purple.withAlphaComponent(0.3)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.titleLabel!.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            button.titleLabel!.widthAnchor.constraint(equalTo: button.widthAnchor, multiplier: 0.7)
        ])
        button.addAction(UIAction(handler: { _ in
            playClickSound()
            UIView.animate(withDuration: 0.2) {
                button.backgroundColor = .white.withAlphaComponent(0.1)
                button.backgroundColor = .purple.withAlphaComponent(0.3)
            }
        }), for: .touchUpInside)
        return button
    }()
    
    private let autoButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "shuffle.circle"), for: .normal)
        button.addAction(UIAction(handler: { _ in
            playClickSound()
        }), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let saveButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.down.fill"), for: .normal)
        button.addAction(UIAction(handler: { _ in
            playClickSound()
        }), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let backToMianButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.backward.circle.fill"), for: .normal)
        button.addAction(UIAction(handler: { _ in
            playClickSound()
        }), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(playerIcon)
        self.addSubview(playerNameLabel)
        self.addSubview(startBattleButton)
        self.addSubview(joinBattleButton)
        self.addSubview(autoButton)
        self.addSubview(saveButton)
        self.addSubview(backToMianButton)
        
        NSLayoutConstraint.activate([
            autoButton.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -10),
            autoButton.widthAnchor.constraint(equalToConstant: 50),
            autoButton.topAnchor.constraint(equalTo: self.startBattleButton.topAnchor),
            saveButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            saveButton.widthAnchor.constraint(equalToConstant: 50),
            saveButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            backToMianButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            backToMianButton.widthAnchor.constraint(equalToConstant: 50),
            backToMianButton.bottomAnchor.constraint(equalTo: joinBattleButton.bottomAnchor),
            startBattleButton.topAnchor.constraint(equalTo: self.playerIcon.topAnchor),
            startBattleButton.rightAnchor.constraint(equalTo: autoButton.leftAnchor,constant: -5),
            startBattleButton.leftAnchor.constraint(greaterThanOrEqualTo: playerIcon.rightAnchor,constant: 20),
            joinBattleButton.bottomAnchor.constraint(equalTo: self.playerIcon.bottomAnchor),
            joinBattleButton.rightAnchor.constraint(equalTo: autoButton.leftAnchor,constant: -5),
            joinBattleButton.leftAnchor.constraint(equalTo: startBattleButton.leftAnchor),
            playerIcon.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 10),
            playerIcon.topAnchor.constraint(equalTo: self.topAnchor),
            playerIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            playerIcon.widthAnchor.constraint(equalToConstant: 150),
            playerNameLabel.leftAnchor.constraint(equalTo: self.playerIcon.leftAnchor,constant: 7),
            playerNameLabel.rightAnchor.constraint(equalTo: self.playerIcon.rightAnchor,constant: -4),
            playerNameLabel.bottomAnchor.constraint(equalTo: playerIcon.bottomAnchor,constant: -3),
        ])
    }
    
    required init?(coder:NSCoder) {
        super.init(coder: coder)
        
        self.addSubview(playerIcon)
        self.addSubview(playerNameLabel)
        self.addSubview(startBattleButton)
        self.addSubview(joinBattleButton)
        self.addSubview(autoButton)
        self.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            autoButton.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -10),
            autoButton.widthAnchor.constraint(equalToConstant: 50),
            autoButton.topAnchor.constraint(equalTo: self.startBattleButton.topAnchor),
            saveButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            saveButton.widthAnchor.constraint(equalToConstant: 50),
            saveButton.topAnchor.constraint(equalTo: joinBattleButton.topAnchor),
            startBattleButton.topAnchor.constraint(equalTo: self.playerIcon.topAnchor),
            startBattleButton.rightAnchor.constraint(equalTo: autoButton.leftAnchor,constant: -5),
            startBattleButton.leftAnchor.constraint(equalTo: playerIcon.rightAnchor,constant: 20),
            joinBattleButton.bottomAnchor.constraint(equalTo: self.playerIcon.bottomAnchor),
            joinBattleButton.rightAnchor.constraint(equalTo: autoButton.leftAnchor,constant: -5),
            joinBattleButton.leftAnchor.constraint(equalTo: playerIcon.rightAnchor,constant: 20),
            playerIcon.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 10),
            playerIcon.topAnchor.constraint(equalTo: self.topAnchor),
            playerIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            playerIcon.widthAnchor.constraint(equalToConstant: 150),
            playerNameLabel.leftAnchor.constraint(equalTo: self.playerIcon.leftAnchor,constant: 7),
            playerNameLabel.rightAnchor.constraint(equalTo: self.playerIcon.rightAnchor,constant: -4),
            playerNameLabel.bottomAnchor.constraint(equalTo: playerIcon.bottomAnchor,constant: -3),
        ])
    }
    
    func configuireAutoButtonTarget(target: AutoButtonTargetSetter) {
        self.autoButton.addTarget(target, action: #selector(target.getRandomAddedMap), for: .touchUpInside)
    }
    
    func configuireStartBattleButtonTarget(target: StartButtonTargetSetter) {
        self.startBattleButton.addTarget(target, action: #selector(target.startBattleButtonTapSelector), for: .touchUpInside)
    }
    
    func configuireJoinBattleButtonTarget(target: JoinButtonTargetSetter) {
        self.joinBattleButton.addTarget(target, action: #selector(target.joinBattleButtonTapSelector), for: .touchUpInside)
    }
    
    func configuireSaveBattleButtonTarget(target: SaveButtonTargetSetter) {
        self.saveButton.addTarget(target, action: #selector(target.saveBattleButtonTapSelector), for: .touchUpInside)
    }
    
    func configuireBackBattleButtonTarget(target: BackButtonTargetSetter) {
        self.backToMianButton.addTarget(target, action: #selector(target.backBattleButtonTapSelector), for: .touchUpInside)
    }
    
    func desableAoutoFillButton() {
        self.autoButton.isUserInteractionEnabled = false
    }
    
}
