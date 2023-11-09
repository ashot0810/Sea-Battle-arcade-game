//
//  GameResultsTableViewController.swift
//  Sea Battle
//
//  Created by Ashot Hovhannisyan on 11.10.23.
//

import UIKit

extension GameResultsTableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 230
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.viewModel.providedData.isEmpty {
            return 0
        } else {
            if section == 0 {
                return 1
            }
            return self.viewModel.providedData.count - 1
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
        let header = self.gameResultsTableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! PlayersTableViewHeaderView
        header.configure()
        if section == 0 {
            header.setTitleLabelText(with: "TOP RESULT")
        } else {
            header.setTitleLabelText(with: "GAME RESULTS")
        }
        header.layer.borderWidth = 5
        header.layer.borderColor = .init(gray: 1, alpha: 0.2)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.gameResultsTableView.dequeueReusableCell(withIdentifier: "cell") as! GameResultsTableViewCell
        let cellData = self.viewModel.providedData[indexPath.row]
        cell.configuire(playerName: cellData.playerName, playerScores: cellData.playerScores, playerImage: cellData.playerIconDescription, opponentName: cellData.opponentName, opponentScores: cellData.opponentScore, opponentImage: cellData.opponentIconDescription, gamingState: cellData.isWinner)
        cell.separatorInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return cell
    }
    
}

extension GameResultsTableViewController: UITableViewDelegate {}

final class GameResultsTableViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "ShipsMapsBackground")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let gameResultsTableView: UITableView = {
        let tableView = UITableView(frame: .zero,style: .grouped)
        tableView.register(GameResultsTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(PlayersTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let backToMainButton: UIButton = {
        let button = UIButton()
        button.setTitle("Main", for: .normal)
        NSLayoutConstraint.activate([
            button.titleLabel!.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            button.titleLabel!.widthAnchor.constraint(equalTo: button.widthAnchor, multiplier: 0.7),
        ])
        button.layer.cornerRadius = 15
        button.backgroundColor = .cyan.withAlphaComponent(0.2)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
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
    
    private let viewModel: GameResultsViewModel = GameResultsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gameResultsTableView.backgroundColor = .clear
        self.backToMainButton.titleLabel?.font = .boldSystemFont(ofSize: 30)
        self.navigationBarDisablier()
        
        self.backToMainButton.addTarget(self, action: #selector(backToMainButtonSelector), for: .touchUpInside)
        
        self.gameResultsTableView.delegate = self
        self.gameResultsTableView.dataSource = self
        
        self.view.addSubview(self.backgroundImage)
        self.view.addSubview(self.gameResultsTableView)
        self.view.addSubview(backToMainButton)
        
        NSLayoutConstraint.activate([
            self.backgroundImage.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.backgroundImage.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.backgroundImage.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.backgroundImage.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.backToMainButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.backToMainButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,constant: -5),
            self.gameResultsTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.gameResultsTableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            self.gameResultsTableView.bottomAnchor.constraint(equalTo: self.backToMainButton.topAnchor,constant: -5),
            self.gameResultsTableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
        ])
        
        self.viewModel.getDataFromDataSource()
        self.viewModel.functionalityWhenDataGiven = { [weak self] in
            DispatchQueue.main.async(qos: .userInteractive) {
                self?.gameResultsTableView.reloadData()
            }
        }
    }
    
    private func navigationBarDisablier() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    @objc private func backToMainButtonSelector(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
