//
//  LeavingView.swift
//  Sea Battle
//
//  Created by Ashot Hovhannisyan on 12.10.23.
//

import UIKit

@objc protocol LeaveButtonTargetSetter {
    @objc func leavingButtonTagetSelector(_ sender: UIButton)
}

@objc protocol StayButtonTargetSetter {
    @objc func stayiningButtonTagetSelector(_ sender: UIButton)
}

final class LeavingView: UIView {
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.8
        imageView.image = UIImage(named: "BannerBackground")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let leavingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 35)
        label.text = "Are you sure?"
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let leaveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Leave", for: .normal)
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
    
    private let stayButton: UIButton = {
        let button = UIButton()
        button.setTitle("Stay", for: .normal)
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        
        self.addSubview(backgroundImage)
        self.addSubview(leavingLabel)
        self.addSubview(stayButton)
        self.addSubview(leaveButton)
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImage.leftAnchor.constraint(equalTo: self.leftAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: self.rightAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            leavingLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            leavingLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            leavingLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor,constant: -20),
            stayButton.rightAnchor.constraint(equalTo: self.centerXAnchor,constant: -10),
            leaveButton.leftAnchor.constraint(equalTo: self.centerXAnchor,constant: 10),
            stayButton.topAnchor.constraint(equalTo: self.leavingLabel.bottomAnchor,constant: 5),
            leaveButton.topAnchor.constraint(equalTo: self.leavingLabel.bottomAnchor,constant: 5)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        
        self.addSubview(backgroundImage)
        self.addSubview(leavingLabel)
        self.addSubview(stayButton)
        self.addSubview(leaveButton)
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImage.leftAnchor.constraint(equalTo: self.leftAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: self.rightAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            leavingLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            leavingLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            leavingLabel.topAnchor.constraint(equalTo: self.topAnchor),
            stayButton.rightAnchor.constraint(equalTo: self.centerXAnchor,constant: -10),
            leaveButton.leftAnchor.constraint(equalTo: self.centerXAnchor,constant: 10),
            stayButton.topAnchor.constraint(equalTo: self.leavingLabel.bottomAnchor,constant: 5),
            leaveButton.topAnchor.constraint(equalTo: self.leavingLabel.bottomAnchor,constant: 5)
        ])
    }
    
    func setLeaveButtonTarget(target: LeaveButtonTargetSetter) {
        self.leaveButton.addTarget(target, action: #selector(target.leavingButtonTagetSelector), for: .touchUpInside)
    }
    
    func setStayButtonTarget(target: StayButtonTargetSetter) {
        self.stayButton.addTarget(target, action: #selector(target.stayiningButtonTagetSelector), for: .touchUpInside)
    }
}
