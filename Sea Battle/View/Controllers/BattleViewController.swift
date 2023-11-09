//
//  BattleViewController.swift
//  Sea Battle
//
//  Created by Ashot Hovhannisyan on 26.09.23.
//

import UIKit
import Lottie
import SimpleKeychain

extension UIViewController {
    func functionalityAboutLastGameResult(opponentName: String, lastGameResult: GameWinnerLoserResult) {
        let blurEffect: UIVisualEffectView = {
            let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
            effectView.translatesAutoresizingMaskIntoConstraints = false
            effectView.alpha = 0
            return effectView
        }()
        
        let winningView: WinnerLoserView = {
            let winLoseView = WinnerLoserView()
            winLoseView.alpha = 0
            winLoseView.translatesAutoresizingMaskIntoConstraints = false
            return winLoseView
        }()
        
        let lightAnimation: LottieAnimationView = {
            let animation = LottieAnimationView(name: "lightAnimation")
            animation.contentMode = .scaleAspectFill
            animation.loopMode = .loop
            animation.animationSpeed = 0.8
            animation.alpha = 0
            animation.translatesAutoresizingMaskIntoConstraints = false
            return animation
        }()
        
        self.view.addSubview(blurEffect)
        
        NSLayoutConstraint.activate([
            blurEffect.topAnchor.constraint(equalTo: self.view.topAnchor),
            blurEffect.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            blurEffect.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            blurEffect.rightAnchor.constraint(equalTo: self.view.rightAnchor),
        ])
        
        DataAboutPlayerSingleton.shared.setConnectingStatus(with: false)
        SessionDisconector.shared.resetSender()
        self.view.addSubview(lightAnimation)
        self.view.addSubview(winningView)
        winningView.setMessageText(with: "You Lose")
        winningView.setPlayersWithScore(by: DataAboutPlayerSingleton.shared.providePlayerName() + " " + "0" + "-" + opponentName + " " + "500")
        playLosingSound()
        
        NSLayoutConstraint.activate([
            winningView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            winningView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            winningView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.6),
            winningView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            lightAnimation.topAnchor.constraint(equalTo: self.view.topAnchor),
            lightAnimation.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            lightAnimation.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            lightAnimation.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
        
        lightAnimation.play()
        
        UIView.animate(withDuration: 3) {
            blurEffect.alpha = 0
            lightAnimation.alpha = 0
            winningView.alpha = 0
            blurEffect.alpha = 1
            winningView.alpha = 1
            lightAnimation.alpha = 1
        }
        
        DataSavingManager.savingGameResult(with: lastGameResult)
        
        
        DataSavingManager.cleanUpUserDefaultsAndKeyChain()
        winningView.hideMainButton()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            UIView.animate(withDuration: 2) {
                blurEffect.alpha = 1
                winningView.alpha = 1
                lightAnimation.alpha = 1
                blurEffect.alpha = 0
                lightAnimation.alpha = 0
                winningView.alpha = 0
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            lightAnimation.stop()
            winningView.removeFromSuperview()
            blurEffect.removeFromSuperview()
            lightAnimation.removeFromSuperview()
        }
    }
}

extension IndexPath {
    func isValid() -> Bool {
        switch self.item {
        case 0,1,2,3,4,5,6,7,8,9,10,11,22,33,44,55,66,77,88,99,110:
            return false
        default:
            return true
        }
    }
}

extension BattleViewController: LeaveButtonTargetSetter, StayButtonTargetSetter {
    func stayiningButtonTagetSelector(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
            self.leavingView.alpha = 1
            self.leavingView.alpha = 0
            self.leavingView.removeFromSuperview()
        }
    }
    
    func leavingButtonTagetSelector(_ sender: UIButton) {
        UIView.animate(withDuration: 1) {
            self.leavingView.alpha = 1
            self.leavingView.alpha = 0
            self.leavingView.removeFromSuperview()
        }
        self.viewModel.askToCleanUp()
        self.viewModel.setGameResultMin()
        self.viewModel.functionalityWhenWinOrLose(false,DataAboutPlayerSingleton.shared.providePlayerName(),"0",self.viewModel.provideOpponentName(),"500")
    }
}

extension BattleViewController: MainPageConfiguirerToPop {
    func handleMainButtonTap(_ sender: UIButton) {
        self.viewModel.askToCleanUp()
        DataSavingManager.savingGameResult(with: self.viewModel.gameResult)
        let vc = self.navigationController?.popViewController(animated: true)
        vc?.navigationController?.popViewController(animated: true)
    }
}

final class BattleViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private var viewModel: ViewModelForBattleViewController!
    
    private let absoluteHeightsForAllSectionsHeaders:CGFloat = 28
    
    private let absolutheHeightForAllSectionsFooters:CGFloat = 5
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "ShipsMapsBackground")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let playerMapCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let planeImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "MilitaryPlane"))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let viewWhenOpponentLeavesTheGame: ErrorMessageView = {
        let view = ErrorMessageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let blurEffect: UIVisualEffectView = {
        let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
        effectView.translatesAutoresizingMaskIntoConstraints = false
        effectView.alpha = 0
        return effectView
    }()

    private let winningView: WinnerLoserView = {
        let winLoseView = WinnerLoserView()
        winLoseView.translatesAutoresizingMaskIntoConstraints = false
        return winLoseView
    }()
    
    private let lightAnimation: LottieAnimationView = {
        let animation = LottieAnimationView(name: "lightAnimation")
        animation.contentMode = .scaleAspectFill
        animation.loopMode = .loop
        animation.animationSpeed = 0.8
        animation.alpha = 0
        animation.translatesAutoresizingMaskIntoConstraints = false
        return animation
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
    
    private let leavingView: LeavingView = {
        let view = LeavingView()
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        navigationBarDisablier()
        
        configuiringWithSectionLayout()
        
        collectionViewRegistering()
        
        self.view.addSubview(backgroundImage)
        self.view.addSubview(playerMapCollectionView)
        self.view.addSubview(backToMianButton)
        self.view.addSubview(blurEffect)
        
        self.backToMianButton.addTarget(self, action: #selector(backBattleButtonTapSelector), for: .touchUpInside)
        self.leavingView.setLeaveButtonTarget(target: self)
        self.leavingView.setStayButtonTarget(target: self)
        
        self.playerMapCollectionView.dataSource = self
        self.playerMapCollectionView.delegate = self
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            playerMapCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            playerMapCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            playerMapCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            playerMapCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            backToMianButton.leftAnchor.constraint(equalTo: self.playerMapCollectionView.leftAnchor,constant: 10),
            backToMianButton.topAnchor.constraint(equalTo: self.playerMapCollectionView.topAnchor),
            blurEffect.topAnchor.constraint(equalTo: view.topAnchor),
            blurEffect.leftAnchor.constraint(equalTo: view.leftAnchor),
            blurEffect.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            blurEffect.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
        
        self.planeImageView.frame.size = CGSize(width: 150, height: 200)
        self.planeImageView.frame.origin = CGPoint(x: -150, y: (self.view.bounds.height/10)*3 + 200)
        self.planeImageView.alpha = 0
        self.view.addSubview(self.planeImageView)
        
        configuireViewModel()
        setUpWithPlayingStatus()
        
        SessionDisconector.shared.setSender(with: self)
        
    }
    
    @objc private func backBattleButtonTapSelector(_ sender: UIButton) {
        self.view.addSubview(self.leavingView)
        
        NSLayoutConstraint.activate([
            leavingView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            leavingView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            leavingView.heightAnchor.constraint(equalToConstant: 150),
            leavingView.widthAnchor.constraint(equalTo:self.view.widthAnchor,multiplier: 0.7)
        ])
        
        UIView.animate(withDuration: 1) {
            self.leavingView.alpha = 0
            self.leavingView.alpha = 1
        }
    }
    
    func functionalityAboutLastGameResult(opponentName: String) {
        self.winningView.hideMainButton()
        self.viewModel.functionalityWhenWinOrLose(false,DataAboutPlayerSingleton.shared.providePlayerName(),"0",opponentName,"500")
        guard let data = try? SimpleKeychain().data(forKey: "oneResult") else {return}
        guard let decodedData = try? JSONDecoder().decode(GameWinnerLoserResult.self, from: data) else {return}
        DataSavingManager.savingGameResult(with: decodedData)
        DataSavingManager.cleanUpUserDefaultsAndKeyChain()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    private func configuiringWithSectionLayout() {
        let layout = UICollectionViewCompositionalLayout { sectionNumber, environment in
            switch sectionNumber {
            case 0:
                let section = self.layoutConfigurationForMapAndShipSections(for: 0)
                section?.decorationItems = [NSCollectionLayoutDecorationItem.background(elementKind: "mapDecor")]
                section?.boundarySupplementaryItems = [NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top),NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(5)), elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)]
                return section
            case 1:
                let section = self.layoutConfigurationForMapAndShipSections(for: 1)
                section?.decorationItems = [NSCollectionLayoutDecorationItem.background(elementKind: "mapDecor")]
                section?.boundarySupplementaryItems = [NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top),NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(5)), elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)]
                return section
            case 2:
                let section = self.layoutConfigurationForMapAndShipSections(for: 2)
                section?.decorationItems = [NSCollectionLayoutDecorationItem.background(elementKind: "mapDecor")]
                section?.boundarySupplementaryItems = [NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top),NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(5)), elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)]
                return section
            default:
                break
            }
            return nil
        }
        layout.register(DecorationViewForMapAndShips.self, forDecorationViewOfKind: "mapDecor")
        let layoutConfiguration = UICollectionViewCompositionalLayoutConfiguration()
        layoutConfiguration.interSectionSpacing = 10
        layout.configuration = layoutConfiguration
        self.playerMapCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    private func layoutConfigurationForMapAndShipSections(for section: Int) -> NSCollectionLayoutSection? {
        switch section {
        case 0:
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/10)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .none
            return section
        case 1:
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/11), heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 0.3, leading: 0.3, bottom: 0.3, trailing: 0.3)
            let innerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/11)), repeatingSubitem: item, count: 11)
            innerGroup.interItemSpacing = .fixed(0)
            let collectiveGroup = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .absolute((self.playerMapCollectionView.bounds.height/10)*3), heightDimension: .fractionalHeight(3/10)), repeatingSubitem: innerGroup,count: 11)
            let section = NSCollectionLayoutSection(group: collectiveGroup)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: (self.view.bounds.width - (self.playerMapCollectionView.bounds.height/10)*3)/2, bottom: 0, trailing: (self.view.bounds.width - (self.playerMapCollectionView.bounds.height/10)*3)/2)
            section.orthogonalScrollingBehavior = .none
            return section
        case 2:
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/11), heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 0.3, leading: 0.3, bottom: 0.3, trailing: 0.3)
            let innerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/11)), repeatingSubitem: item, count: 11)
            innerGroup.interItemSpacing = .fixed(0)
            let collectiveGroup = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .absolute((self.playerMapCollectionView.bounds.height/10)*4), heightDimension: .fractionalHeight(4/10)), repeatingSubitem: innerGroup,count: 11)
            let section = NSCollectionLayoutSection(group: collectiveGroup)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: (self.view.bounds.width - (self.playerMapCollectionView.bounds.height/10)*4)/2, bottom: 0, trailing: (self.view.bounds.width - (self.playerMapCollectionView.bounds.height/10)*4)/2)
            section.orthogonalScrollingBehavior = .none
            return section
        default:
            break
        }
        return nil
    }

    private func navigationBarDisablier() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func setViewModel(with viewModel: ViewModelForBattleViewController, conectivityHandler: MultiplayerConectionAsMPCHandler, playingStatus: PlayingStatus) {
        self.viewModel = viewModel
        self.viewModel.setMultipeerConnectivityHandler(with: conectivityHandler)
        self.viewModel.setPlayingStatus(with: playingStatus)
    }
    
    private func configuireViewModel() {
                
        self.winningView.setButtonHandler(with: self)
        
        self.viewModel.functionalityWhenDataForSelfMapProvided = { [weak self] in
            guard let self else {return}
            DispatchQueue.main.async(qos: .userInteractive) {
                self.playerMapCollectionView.reloadData()
            }
        }
        self.viewModel.functionalityWhenDataForOpponentMapProvided = { [weak self] in
            guard let self else {return}
            self.playerMapCollectionView.reloadData()
        }
        self.viewModel.functionalityWhenPlayingStatusChanged = { [weak self] in
            guard let self else {return}
            DispatchQueue.main.async(qos: .userInteractive) {
                guard let cell = self.playerMapCollectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? PlayerCellForBattleViewController else {
                    if self.viewModel.providePlayingStatus() == .canPlay {
                        self.playerMapCollectionView.isUserInteractionEnabled = true
                    } else {
                        self.playerMapCollectionView.isUserInteractionEnabled = false
                    }
                    return
                }
                if self.viewModel.providePlayingStatus() == .canPlay {
                    cell.enablePlayerIndicator()
                    cell.desableOpponentIndicator()
                    self.playerMapCollectionView.isUserInteractionEnabled = true
                } else {
                    cell.enableOpponentIndicator()
                    cell.desablePlayerIndicator()
                    self.playerMapCollectionView.isUserInteractionEnabled = false
                }
            }
        }
        self.viewModel.getDataForSelfMap()
        self.viewModel.getDataForOpponentMap()
        self.viewModel.functionalityWhenTimerUpdates = { [weak self] in
            guard let self else {return}
            DispatchQueue.main.async(qos:.userInteractive) {
                guard let cell = (self.playerMapCollectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? PlayerCellForBattleViewController) else {return}
                if self.viewModel.secondsRemained <= 9 && self.viewModel.secondsRemained > 0 {
                    cell.updateTimerValue(with: "00:0\(self.viewModel.secondsRemained)")
                } else {
                    cell.updateTimerValue(with: "00:\(self.viewModel.secondsRemained)")
                }
                if self.viewModel.secondsRemained == 0 {
                    cell.updateTimerValue(with: "")
                }
            }
        }
        
        self.viewModel.functionalityWhenTimerUpdatesWaitingOpponent = { [weak self] in
            guard let self else {return}
            DispatchQueue.main.async(qos:.userInteractive) {
                if self.viewModel.secondsRemainedForConnect <= 9 && self.viewModel.secondsRemained > 0 {
                    self.viewWhenOpponentLeavesTheGame.setLabelText(with: "Waiting for opponent  00:0\(self.viewModel.secondsRemainedForConnect)")
                } else {
                    self.viewWhenOpponentLeavesTheGame.setLabelText(with: "Waiting for opponent  00:\(self.viewModel.secondsRemainedForConnect)")
                }
                if self.viewModel.secondsRemainedForConnect == 0 {
                    self.viewWhenOpponentLeavesTheGame.setLabelText(with: "")
                }
            }
        }
        
        self.viewModel.functionalityOnHit = { [weak self] in
            playAirplaneSound()
            guard let self else {return}
            DispatchQueue.main.async(qos: .userInteractive) {
                self.planeImageView.frame.origin = CGPoint(x: -150, y: (self.view.bounds.height/10)*3 + 200)
                self.planeImageView.alpha = 1
                UIView.animate(withDuration: 3) {
                    self.planeImageView.frame.origin = CGPoint(x: self.view.bounds.width, y:  -1 * self.planeImageView.bounds.height)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, qos: .userInteractive) {
                    self.planeImageView.alpha = 0
                    self.playerMapCollectionView.reloadData()
                    self.viewModel.group.leave()
                }
            }
        }
        
        self.viewModel.functionalityWhenOpponentDisconnected = { [weak self] in
            playClickSound()
            guard let self else {return}
            DispatchQueue.main.async(qos: .userInteractive) {
                self.viewWhenOpponentLeavesTheGame.alpha = 1
                self.viewWhenOpponentLeavesTheGame.setLabelText(with: "Waiting for opponent  00:\(self.viewModel.secondsRemainedForConnect)")
                self.view.addSubview(self.viewWhenOpponentLeavesTheGame)
                NSLayoutConstraint.activate([
                    self.viewWhenOpponentLeavesTheGame.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                    self.viewWhenOpponentLeavesTheGame.centerYAnchor.constraint(equalTo:self.view.centerYAnchor)
                ])
            }
        }
        
        self.viewModel.functionalityWhenScoresChanged = { [weak self] in
            guard let self else {return}
            DispatchQueue.main.async(qos: .userInteractive) {
                self.playerMapCollectionView.reloadData()
            }
        }
        
        self.viewModel.desablingSetterOfCollectionView = { [weak self] in
            guard let self else {return}
            DispatchQueue.main.async(qos: .userInteractive) {
                self.playerMapCollectionView.isUserInteractionEnabled = false
            }
        }
        
        self.viewModel.functionalityWhenConnectionReesteablished = { [weak self] in
            guard let self else {return}
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.2) {
                    self.viewWhenOpponentLeavesTheGame.alpha = 0
                }
                if self.view.subviews.contains(self.viewWhenOpponentLeavesTheGame) {
                    self.viewWhenOpponentLeavesTheGame.removeFromSuperview()
                }
            }
        }
        
        self.viewModel.functionalityWhenWinOrLose = { isWinner, playerName,playerScores,opponentName,opponentScores in
            DataAboutPlayerSingleton.shared.setConnectingStatus(with: false)
            SessionDisconector.shared.resetSender()
            DispatchQueue.main.async(qos: .userInteractive) {
                self.planeImageView.alpha = 0
                self.viewWhenOpponentLeavesTheGame.alpha = 0
                self.playerMapCollectionView.isUserInteractionEnabled = false
                self.viewModel.resetAllFunctionalitties()
                self.view.addSubview(self.lightAnimation)
                self.view.addSubview(self.winningView)
                
                if isWinner {
                    self.winningView.setMessageText(with: "You Win")
                    playWinningSound()
                } else {
                    self.winningView.setMessageText(with: "You Lose")
                    playLosingSound()
                }
                
                self.winningView.setPlayersWithScore(by: playerName + " " + playerScores + "-" + opponentName + " " + opponentScores)
                
                NSLayoutConstraint.activate([
                    self.winningView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                    self.winningView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                    self.winningView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.6),
                    self.winningView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
                    self.lightAnimation.topAnchor.constraint(equalTo: self.view.topAnchor),
                    self.lightAnimation.leftAnchor.constraint(equalTo: self.view.leftAnchor),
                    self.lightAnimation.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                    self.lightAnimation.rightAnchor.constraint(equalTo: self.view.rightAnchor)
                ])
                
                if let cell = self.playerMapCollectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? PlayerCellForBattleViewController {
                    cell.resetTimerView()
                }
                
                self.lightAnimation.play()
                
                UIView.animate(withDuration: 3) {
                    self.blurEffect.alpha = 0
                    self.lightAnimation.alpha = 0
                    self.winningView.alpha = 0
                    self.blurEffect.alpha = 1
                    self.winningView.alpha = 1
                    self.lightAnimation.alpha = 1
                }
            }
        }
    }
    
    private func setUpWithPlayingStatus() {
        if self.viewModel.providePlayingStatus() == .canPlay {
            self.playerMapCollectionView.isUserInteractionEnabled = true
        } else {
            self.playerMapCollectionView.isUserInteractionEnabled = false
        }
    }
    
}

extension BattleViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1{
            return self.viewModel.providedDataForSelfMapSection.count
        } else {
            return self.viewModel.providedDataForOpponentMapSection.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = self.playerMapCollectionView.dequeueReusableCell(withReuseIdentifier: "playerCell", for: indexPath) as! PlayerCellForBattleViewController
            cell.configuire(name: self.viewModel.provideOpponentName(), icon: self.viewModel.provideOpponentIcon())
            cell.setPlayerScore(with: self.viewModel.playerScores)
            cell.setOpponentScore(with: self.viewModel.opponentScores)
            if self.viewModel.connectorStatus == .starter {
                cell.enablePlayerIndicator()
                cell.desableOpponentIndicator()
            } else {
                cell.enableOpponentIndicator()
                cell.desablePlayerIndicator()
            }
            return cell
        } else if indexPath.section == 1 {
            if !(["","A","B","C","D","E","F","G","H","I","J","1","2","3","4","5","6","7","8","9","10"].contains(self.viewModel.providedDataForSelfMapSection[indexPath.item])) {
                let cell = self.playerMapCollectionView.dequeueReusableCell(withReuseIdentifier: "cellMap", for: indexPath) as! CellForMapAndShips
                if self.viewModel.providedDataForSelfMapSection[indexPath.item] == "mappCelll" {
                    cell.configuire(with: self.viewModel.providedDataForSelfMapSection[indexPath.item])
                } else {
                    cell.configuireByContained(with: self.viewModel.providedDataForSelfMapSection[indexPath.item])
                }
                return cell
            } else {
                let cell = self.playerMapCollectionView.dequeueReusableCell(withReuseIdentifier: "colRowIndentificatorCell", for: indexPath) as! MapColumnOrRowCell
                cell.configuire(with: self.viewModel.providedDataForSelfMapSection[indexPath.item])
                return cell
            }
        } else {
            if !(["","A","B","C","D","E","F","G","H","I","J","1","2","3","4","5","6","7","8","9","10"].contains(self.viewModel.providedDataForOpponentMapSection[indexPath.item])) {
                let cell = self.playerMapCollectionView.dequeueReusableCell(withReuseIdentifier: "cellMap", for: indexPath) as! CellForMapAndShips
                if self.viewModel.providedDataForOpponentMapSection[indexPath.item] == "mappCelll" {
                    cell.configuire(with: self.viewModel.providedDataForOpponentMapSection[indexPath.item])
                } else {
                    cell.configuireByContained(with: self.viewModel.providedDataForOpponentMapSection[indexPath.item])
                }
                return cell
            } else {
                let cell = self.playerMapCollectionView.dequeueReusableCell(withReuseIdentifier: "colRowIndentificatorCell", for: indexPath) as! MapColumnOrRowCell
                cell.configuire(with: self.viewModel.providedDataForOpponentMapSection[indexPath.item])
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = self.playerMapCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerMap", for: indexPath) as! MapPlayerSectionHeaderView
            if indexPath.section == 0 {
                header.configuire(with: "Players")
            }
            if indexPath.section == 1 {
                header.configuire(with: "Map")
            }
            if indexPath.section == 2 {
                header.configuire(with: "Oponent's map")
            }
            return header
        }
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = self.playerMapCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "mapFooter", for: indexPath) as! MapShipsFooterView
            return footer
        }
        return UICollectionReusableView.init()
    }
    
    func collectionViewRegistering() {
        playerMapCollectionView.register(CellForMapAndShips.self, forCellWithReuseIdentifier: "cellMap")
        playerMapCollectionView.register(PlayerCellForBattleViewController.self, forCellWithReuseIdentifier: "playerCell")
        playerMapCollectionView.register(MapPlayerSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerMap")
        playerMapCollectionView.register(MapShipsFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "mapFooter")
        playerMapCollectionView.register(MapColumnOrRowCell.self, forCellWithReuseIdentifier: "colRowIndentificatorCell")
    }
}

extension BattleViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.isValid() && self.viewModel.canHit(to: indexPath) && indexPath.section == 2 {
            playClickSound()
            let cell = self.playerMapCollectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as! PlayerCellForBattleViewController
            cell.resetTimerView()
            self.viewModel.handleHitOnopponentMap(on: indexPath)
        }
    }
}
