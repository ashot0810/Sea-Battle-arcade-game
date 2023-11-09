//
//  PlayerSetFirstPageViewController.swift
//  Sea Battle
//
//  Created by Ashot Hovhannisyan on 14.10.23.
//

import UIKit
import Lottie

protocol PlayerSetFirstPageViewControllerDelegate: AnyObject {
    func playerSetFirstPageViewControllerDataSetted(_ sender:PlayerSetFirstPageViewController)
}

extension PlayerSetFirstPageViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textFieldForPlayerName.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if self.textFieldForPlayerName.text?.count == 0 {
            self.gameButton.isEnabled = false
        } else {
            if self.isGenderSetted {
                self.gameButton.isEnabled = true
            } else {
                self.gameButton.isEnabled = false
            }
        }
    }
}

final class PlayerSetFirstPageViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "firsPageBackground")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let shipsImage: PlayerViewForMainPage = {
        let view = PlayerViewForMainPage()
        view.configure()
        view.desableGestureRecognizer()
        view.resetPlayerNameAsMessage(with: "Welcome to the battle world!")
        view.setPlayerImage(with: UIImage(named: "settPageBackground"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let gameNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white.withAlphaComponent(1)
        label.font = .boldSystemFont(ofSize: 65)
        label.text = "Sea Battle"
        label.textAlignment = .center
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let configurationAnimationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "configuire")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.5
        animationView.clipsToBounds = true
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.alpha = 0
        return animationView
    }()
    
    private let setPlayerNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.minimumScaleFactor = 0.2
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        label.text = "Set player name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let setPlayerGenderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.minimumScaleFactor = 0.2
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        label.text = "Set player gender"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let girlLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white.withAlphaComponent(0.7)
        label.minimumScaleFactor = 0.2
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        label.text = "girl"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let boyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white.withAlphaComponent(0.7)
        label.minimumScaleFactor = 0.2
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        label.text = "boy"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textFieldForPlayerName: UITextField = {
        let textField = UITextField()
        textField.returnKeyType = .done
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.placeholder = "Enter player name"
        textField.textColor = .white
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white.withAlphaComponent(0.4)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let gameButton: UIButton = {
        let button = UIButton()
        button.setTitle("Game", for: .normal)
        NSLayoutConstraint.activate([
            button.titleLabel!.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            button.titleLabel!.widthAnchor.constraint(equalTo: button.widthAnchor, multiplier: 0.7),
        ])
        button.layer.cornerRadius = 15
        button.backgroundColor = .cyan.withAlphaComponent(0.2)
        button.titleLabel?.font = .boldSystemFont(ofSize: 30)
        button.addAction(UIAction(handler: { _ in
            playClickSound()
            UIView.animate(withDuration: 0.2) {
                button.backgroundColor = .white.withAlphaComponent(0.1)
                button.backgroundColor = .cyan.withAlphaComponent(0.2)
            }
        }), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let tapToSetGenderBoyGestureRecognizer: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        return gesture
    }()
    
    private let tapToSetGenderGirlGestureRecognizer: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        return gesture
    }()
    
    private var isGenderSetted: Bool = false {
        willSet {
            if newValue && self.textFieldForPlayerName.text?.count != 0 {
                self.gameButton.isEnabled = true
            }
        }
    }
    
    weak var delegate: PlayerSetFirstPageViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        playGameSound()
        
        self.view.addSubview(self.backgroundImage)
        self.view.addSubview(self.shipsImage)
        self.view.addSubview(self.gameNameLabel)
        self.view.addSubview(self.setPlayerNameLabel)
        self.view.addSubview(self.textFieldForPlayerName)
        self.view.addSubview(self.setPlayerGenderLabel)
        self.view.addSubview(self.boyLabel)
        self.view.addSubview(self.girlLabel)
        self.view.addSubview(self.gameButton)
        
        self.boyLabel.addGestureRecognizer(self.tapToSetGenderBoyGestureRecognizer)
        self.girlLabel.addGestureRecognizer(self.tapToSetGenderGirlGestureRecognizer)
        
        self.tapToSetGenderBoyGestureRecognizer.addTarget(self, action: #selector(tapToActivateGender))
        self.tapToSetGenderGirlGestureRecognizer.addTarget(self, action: #selector(tapToActivateGender))
        self.gameButton.addTarget(self, action: #selector(gameButtonSelector), for: .touchUpInside)
        
        self.textFieldForPlayerName.delegate = self
        
        self.boyLabel.isUserInteractionEnabled = true
        self.girlLabel.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            self.backgroundImage.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.backgroundImage.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.backgroundImage.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.backgroundImage.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.gameNameLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.gameNameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.setPlayerNameLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.setPlayerNameLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor,constant: -10),
            self.shipsImage.topAnchor.constraint(equalTo: self.gameNameLabel.bottomAnchor,constant: 5),
            self.shipsImage.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.shipsImage.bottomAnchor.constraint(equalTo: self.setPlayerNameLabel.topAnchor,constant: -5),
            self.shipsImage.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.textFieldForPlayerName.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.textFieldForPlayerName.topAnchor.constraint(equalTo: self.setPlayerNameLabel.bottomAnchor, constant: 10),
            self.textFieldForPlayerName.leftAnchor.constraint(equalTo: self.setPlayerNameLabel.leftAnchor,constant: -10),
            self.textFieldForPlayerName.rightAnchor.constraint(equalTo: self.setPlayerNameLabel.rightAnchor, constant: 10),
            self.textFieldForPlayerName.heightAnchor.constraint(equalToConstant: 60),
            self.setPlayerGenderLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.setPlayerGenderLabel.topAnchor.constraint(equalTo: self.textFieldForPlayerName.bottomAnchor, constant: 10),
            self.boyLabel.leftAnchor.constraint(equalTo: self.setPlayerGenderLabel.leftAnchor, constant: 10),
            self.boyLabel.topAnchor.constraint(equalTo: setPlayerGenderLabel.bottomAnchor,constant: 5),
            self.girlLabel.rightAnchor.constraint(equalTo: self.setPlayerGenderLabel.rightAnchor, constant: -10),
            self.girlLabel.topAnchor.constraint(equalTo: self.setPlayerGenderLabel.bottomAnchor, constant: 5),
            self.gameButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.gameButton.topAnchor.constraint(equalTo:self.boyLabel.bottomAnchor, constant: 20),
        ])
        
        self.gameButton.isEnabled = false
        self.navigationBarDisablier()

    }
    
    private func navigationBarDisablier() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    @objc private func tapToActivateGender(_ sender: UITapGestureRecognizer) {
        if let label = sender.view as? UILabel {
            if label === self.boyLabel {
                label.textColor = .gray.withAlphaComponent(0.6)
                self.girlLabel.textColor = .white.withAlphaComponent(0.7)
            } else {
                label.textColor = .gray.withAlphaComponent(0.6)
                self.boyLabel.textColor = .white.withAlphaComponent(0.7)
            }
            self.isGenderSetted = true
            guard let text = label.text else {return}
            DataSavingManager.savePlayerGender(with: text)
        }
    }
    
    @objc private func gameButtonSelector(_ sender: UIButton) {
        DataSavingManager.savePlayerName(with: self.textFieldForPlayerName.text!)
        DataSavingManager.saveStateIsSetted()
        DataAboutPlayerSingleton.shared.reload()
        self.view.addSubview(self.configurationAnimationView)
        NSLayoutConstraint.activate([
            self.configurationAnimationView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.configurationAnimationView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            self.configurationAnimationView.widthAnchor.constraint(equalTo:self.view.widthAnchor,multiplier: 0.7),
            self.configurationAnimationView.heightAnchor.constraint(equalTo:self.view.heightAnchor,multiplier: 0.3),
        ])
        
        UIView.animate(withDuration: 0.5) {
            self.configurationAnimationView.alpha = 0
            self.configurationAnimationView.alpha = 1
            self.configurationAnimationView.play()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.delegate?.playerSetFirstPageViewControllerDataSetted(self)
            UIView.animate(withDuration: 0.5) {
                self.configurationAnimationView.alpha = 1
                self.configurationAnimationView.alpha = 0
                self.dismiss(animated: true)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.configurationAnimationView.stop()
                    self.configurationAnimationView.removeFromSuperview()
                }
            }
        }
    }
}
