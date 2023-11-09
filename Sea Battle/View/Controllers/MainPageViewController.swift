//
//  MainPageViewController.swift
//  Sea Battle
//
//  Created by Ashot Hovhannisyan on 28.09.23.
//

import UIKit
import PhotosUI

extension MainPageViewController: PlayerSetFirstPageViewControllerDelegate {
    func playerSetFirstPageViewControllerDataSetted(_ sender: PlayerSetFirstPageViewController) {
        self.reloadPlayerNameAndIcon()
    }
}

extension MainPageViewController: SliderValueChangementTargetSetter, MuteGestureTargetSetter, HaptickMuteGestureTargetSetter, TapToOpenPhotosLibraryGestureTargetSetter {
    func tapToOpenPhotosLibraryGestureSelector(_ sender: UITapGestureRecognizer) {
        self.present(self.photosLibrary, animated: true)
    }
                                                        
    @objc func haptickMuteGestureTargetSelector(_ sender: UITapGestureRecognizer) {
        if AudioEffectsManager.shared.provideHaptickState() {
            self.settingsView.changeHaptickImage(with: UIImage(systemName: "waveform.slash"))
            self.viewModel.configuireHaptick(with: false)
        } else {
            self.settingsView.changeHaptickImage(with: UIImage(systemName: "waveform"))
            self.viewModel.configuireHaptick(with: true)
        }
    }
    
    @objc func muteGestureTargetSelector(_ sender: UITapGestureRecognizer) {
        if self.settingsView.provideSliderValue() > 0 {
            self.viewModel.setVolumeSliderValue(with: self.settingsView.provideSliderValue())
            self.viewModel.configuirePlayersVolume(with: 0)
            self.settingsView.changeVolumeImage(with: UIImage(systemName: "volume.slash.fill"))
            self.settingsView.changeValueOfSlider(with: 0)
        } else if self.settingsView.provideSliderValue() == 0 {
            if let volume = self.viewModel.volumeSliderValue {
                self.viewModel.configuirePlayersVolume(with: volume)
                switch volume {
                case 0:
                    self.settingsView.changeVolumeImage(with: UIImage(systemName: "volume.slash.fill"))
                case 0.0001...0.5:
                    self.settingsView.changeVolumeImage(with: UIImage(systemName: "volume.1.fill"))
                case 0.50001...0.7:
                    self.settingsView.changeVolumeImage(with: UIImage(systemName: "volume.2.fill"))
                case 0.70001...1:
                    self.settingsView.changeVolumeImage(with: UIImage(systemName: "volume.3.fill"))
                default:
                    break
                }
                self.settingsView.changeValueOfSlider(with: volume)
            } else {
                self.viewModel.configuirePlayersVolume(with: 1)
                self.settingsView.changeVolumeImage(with: UIImage(systemName: "volume.3.fill"))
                self.settingsView.changeValueOfSlider(with: 1)
            }
        } else {
            return
        }
    }
    
    @objc func slidervalueChangementSelector(_ sender: UISlider) {
        switch sender.value {
        case 0:
            self.settingsView.changeVolumeImage(with: UIImage(systemName: "volume.slash.fill"))
        case 0.0001...0.5:
            self.settingsView.changeVolumeImage(with: UIImage(systemName: "volume.1.fill"))
        case 0.50001...0.7:
            self.settingsView.changeVolumeImage(with: UIImage(systemName: "volume.2.fill"))
        case 0.70001...1:
            self.settingsView.changeVolumeImage(with: UIImage(systemName: "volume.3.fill"))
        default:
            break
        }
        self.viewModel.configuirePlayersVolume(with: sender.value)
    }
}

extension MainPageViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        self.dismiss(animated: true)
        guard let _ = results.first?.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { [weak self] result, _ in
            guard let self, let image = result as? UIImage else {return}
            self.viewModel.askToSetPlayerImage(with: image)
            self.playerView.setPlayerImage(with: image)
        }) else {return}
    }
}

final class MainPageViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private let viewModel: MainPageViewModel = MainPageViewModel()
        
    private let backgroundImage: UIImageView = {
       let imageView = UIImageView()
       imageView.contentMode = .scaleAspectFill
       imageView.image = UIImage(named: "ShipsMapsBackground")
       imageView.translatesAutoresizingMaskIntoConstraints = false
       return imageView
   }()
    
    private let blurEffect: UIVisualEffectView = {
        let effect = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        effect.alpha = 0
        effect.translatesAutoresizingMaskIntoConstraints = false
        return effect
    }()
    
    private let photosLibrary: PHPickerViewController = {
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        configuration.selectionLimit = 1
        configuration.filter = .any(of: [.images,.not(.livePhotos)])
        let viewController = PHPickerViewController(configuration: configuration)
        return viewController
    }()
    
    private let gameNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white.withAlphaComponent(0.8)
        label.font = .boldSystemFont(ofSize: 55)
        label.text = "Sea Battle"
        label.textAlignment = .center
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let playerView: PlayerViewForMainPage = {
        let view = PlayerViewForMainPage()
        view.configure()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let startNewGameButton: UIButton = {
        let button = UIButton()
        button.setTitle("New Game", for: .normal)
        NSLayoutConstraint.activate([
            button.titleLabel!.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            button.titleLabel!.widthAnchor.constraint(equalTo: button.widthAnchor, multiplier: 0.7)
        ])
        button.layer.cornerRadius = 10
        button.backgroundColor = .cyan.withAlphaComponent(0.4)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.addAction(UIAction(handler: { _ in
            playClickSound()
            UIView.animate(withDuration: 0.2) {
                button.backgroundColor = .white.withAlphaComponent(0.1)
                button.backgroundColor = .cyan.withAlphaComponent(0.4)
            }
        }), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let loadGameButton: UIButton = {
        let button = UIButton()
        button.setTitle("Load Game", for: .normal)
        NSLayoutConstraint.activate([
            button.titleLabel!.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            button.titleLabel!.widthAnchor.constraint(equalTo: button.widthAnchor, multiplier: 0.7)
        ])
        button.layer.cornerRadius = 10
        button.backgroundColor = .cyan.withAlphaComponent(0.4)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.addAction(UIAction(handler: { _ in
            playClickSound()
            UIView.animate(withDuration: 0.2) {
                button.backgroundColor = .white.withAlphaComponent(0.1)
                button.backgroundColor = .cyan.withAlphaComponent(0.4)
            }
        }), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let gameResultsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Game Results", for: .normal)
        NSLayoutConstraint.activate([
            button.titleLabel!.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            button.titleLabel!.widthAnchor.constraint(equalTo: button.widthAnchor, multiplier: 0.7)
        ])
        button.layer.cornerRadius = 10
        button.backgroundColor = .cyan.withAlphaComponent(0.4)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.addAction(UIAction(handler: { _ in
            playClickSound()
            UIView.animate(withDuration: 0.2) {
                button.backgroundColor = .white.withAlphaComponent(0.1)
                button.backgroundColor = .cyan.withAlphaComponent(0.4)
            }
        }), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let settingButton: UIButton = {
        let button = UIButton()
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.setImage(UIImage(systemName: "gearshape"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let settingsView: SettiingsView = {
        let view = SettiingsView()
        view.configure()
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let thanksMessageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 23)
        label.minimumScaleFactor = 0.2
        label.text = "Thanks for relaxing with us"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dismissTapGestureRecognizer: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        return gesture
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let isSetted = UserDefaults(suiteName: "group.io.SeaBattleid.myapp")?.bool(forKey: "setted") {
            if isSetted {
                playGameSound()
            }
        }
        
        self.playerView.isUserInteractionEnabled = true
        
        self.settingsView.setSliderTarget(with: self)
        self.settingsView.muteGestureTarget(with: self)
        self.settingsView.haptickMuteGestureTarget(with: self)
        self.playerView.setGesturesTarget(target: self)

        self.view.addSubview(backgroundImage)
        self.view.addSubview(playerView)
        self.view.addSubview(gameNameLabel)
        self.view.addSubview(startNewGameButton)
        self.view.addSubview(loadGameButton)
        self.view.addSubview(gameResultsButton)
        self.view.addSubview(thanksMessageLabel)
        self.view.addSubview(settingButton)
        
        NSLayoutConstraint.activate([
            self.backgroundImage.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.backgroundImage.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.backgroundImage.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.backgroundImage.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.gameNameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.gameNameLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.playerView.topAnchor.constraint(equalTo: self.gameNameLabel.bottomAnchor,constant: 5),
            self.playerView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor,constant: 10),
            self.playerView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor,constant: -10),
            self.playerView.heightAnchor.constraint(equalTo: self.view.heightAnchor,multiplier: 1/4),
            self.thanksMessageLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.thanksMessageLabel.topAnchor.constraint(equalTo: self.playerView.bottomAnchor,constant: 20),
            self.startNewGameButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.startNewGameButton.topAnchor.constraint(equalTo: self.view.centerYAnchor,constant: 5),
            self.loadGameButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.loadGameButton.topAnchor.constraint(equalTo: self.startNewGameButton.bottomAnchor,constant: 20),
            self.gameResultsButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.gameResultsButton.topAnchor.constraint(equalTo: self.loadGameButton.bottomAnchor,constant: 20),
            self.settingButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.settingButton.topAnchor.constraint(equalTo: self.gameResultsButton.bottomAnchor,constant: 70),
            self.settingButton.heightAnchor.constraint(equalToConstant: 50),
            self.settingButton.widthAnchor.constraint(equalToConstant: 50),
        ])
        
        self.startNewGameButton.addTarget(self, action: #selector(startNewGameButtonSelector), for: .touchUpInside)
        self.gameResultsButton.addTarget(self, action: #selector(gameResultsButtonSelector), for: .touchUpInside)
        self.loadGameButton.addTarget(self, action: #selector(loadGameButtonSelector), for: .touchUpInside)
        self.settingButton.addTarget(self, action: #selector(settingButtonSelector), for: .touchUpInside)
        self.photosLibrary.delegate = self
        
        self.configuireAudioSystem()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let isSetted = UserDefaults(suiteName: "group.io.SeaBattleid.myapp")?.bool(forKey: "setted") {
            if !isSetted {
                let vc = PlayerSetFirstPageViewController()
                vc.delegate = self
                vc.isModalInPresentation = true
                self.present(vc, animated: true)
            }
        } else {
            let vc = PlayerSetFirstPageViewController()
            vc.delegate = self
            vc.isModalInPresentation = true
            self.present(vc, animated: true)
        }
    }
    
    @objc func startNewGameButtonSelector(_ sender: UIButton) {
        self.show(ShipMapConfigurationViewController(), sender: nil)
    }
    
    @objc func loadGameButtonSelector(_ sender: UIButton) {
        self.show(SavedItemsTableViewController(), sender: nil)
    }
    
    @objc func gameResultsButtonSelector(_ sender: UIButton) {
        self.show(GameResultsTableViewController(), sender: nil)
    }
    
    @objc func settingButtonSelector(_ sender: UIButton) {
        
        self.view.addSubview(self.blurEffect)
        self.view.addSubview(self.settingsView)
        
        self.startNewGameButton.isUserInteractionEnabled = false
        self.loadGameButton.isUserInteractionEnabled = false
        self.gameResultsButton.isUserInteractionEnabled = false
        self.settingButton.isUserInteractionEnabled = false
        self.playerView.isUserInteractionEnabled = false
        
        self.blurEffect.addGestureRecognizer(self.dismissTapGestureRecognizer)
        self.dismissTapGestureRecognizer.addTarget(self, action: #selector(tapToDismissGestureRecognizer))
        self.playerView.setGesturesTarget(target: self)
        
        NSLayoutConstraint.activate([
            self.blurEffect.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.blurEffect.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.blurEffect.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.blurEffect.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.settingsView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.settingsView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.settingsView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.13),
            self.settingsView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7)
        ])
        
        UIView.animate(withDuration: 0.8) {
            self.blurEffect.alpha = 0
            self.settingsView.alpha = 0
            self.blurEffect.alpha = 0.8
            self.settingsView.alpha = 1
        }
        
        self.blurEffect.isUserInteractionEnabled = true

    }
    
    @objc func tapToDismissGestureRecognizer(_ sender: UITapGestureRecognizer) {
        
        self.blurEffect.isUserInteractionEnabled = false
        self.blurEffect.removeGestureRecognizer(sender)
        
        UIView.animate(withDuration: 1) {
            self.blurEffect.alpha = 0.8
            self.settingsView.alpha = 1
            self.blurEffect.alpha = 0
            self.settingsView.alpha = 0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.settingButton.isUserInteractionEnabled = true
            self.startNewGameButton.isUserInteractionEnabled = true
            self.loadGameButton.isUserInteractionEnabled = true
            self.gameResultsButton.isUserInteractionEnabled = true
            self.playerView.isUserInteractionEnabled = true
        }
        
    }
    
    func configuireAudioSystem() {
        let volume = DataSavingManager.providePlayersVolume()
        let state = DataSavingManager.provideHaptickState()
        switch volume {
        case 0:
            self.settingsView.changeVolumeImage(with: UIImage(systemName: "volume.slash.fill"))
        case 0.0001...0.5:
            self.settingsView.changeVolumeImage(with: UIImage(systemName: "volume.1.fill"))
        case 0.50001...0.7:
            self.settingsView.changeVolumeImage(with: UIImage(systemName: "volume.2.fill"))
        case 0.70001...1:
            self.settingsView.changeVolumeImage(with: UIImage(systemName: "volume.3.fill"))
        default:
            break
        }
        
        self.settingsView.changeValueOfSlider(with: volume)
        self.viewModel.configuirePlayersVolume(with: volume)
        
        if state {
            self.settingsView.changeHaptickImage(with: UIImage(systemName: "waveform"))
            self.viewModel.configuireHaptick(with: true)
        } else {
            self.settingsView.changeHaptickImage(with: UIImage(systemName: "waveform.slash"))
            self.viewModel.configuireHaptick(with: false)
        }
    }
    
    func reloadPlayerNameAndIcon() {
        self.playerView.reload()
    }
    
}
