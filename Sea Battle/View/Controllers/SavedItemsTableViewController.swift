//
//  SavedItemsTableViewCOntroller.swift
//  Sea Battle
//
//  Created by Ashot Hovhannisyan on 14.10.23.
//

import UIKit
import Lottie

final class SavedItemsTableViewController: UIViewController {
    
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
    
    private let savedItemsTableView: UITableView = {
        let tableView = UITableView(frame: .zero,style: .grouped)
        tableView.register(SavedItemTableViewCell.self, forCellReuseIdentifier: "cell")
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
    
    private let animationViewOfLoading: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "loading")
        animationView.contentMode = .scaleAspectFit
        animationView.clipsToBounds = true
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.2
        animationView.alpha = 0
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    
    private let viewModel: SavedItemsViewModel = SavedItemsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.savedItemsTableView.backgroundColor = .clear
        self.backToMainButton.titleLabel?.font = .boldSystemFont(ofSize: 30)
        self.navigationBarDisablier()
        
        self.backToMainButton.addTarget(self, action: #selector(backToMainButtonSelector), for: .touchUpInside)
        
        self.savedItemsTableView.delegate = self
        self.savedItemsTableView.dataSource = self
        
        self.view.addSubview(self.backgroundImage)
        self.view.addSubview(self.savedItemsTableView)
        self.view.addSubview(self.backToMainButton)
        
        NSLayoutConstraint.activate([
            self.backgroundImage.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.backgroundImage.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.backgroundImage.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.backgroundImage.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.backToMainButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.backToMainButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,constant: -5),
            self.savedItemsTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.savedItemsTableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            self.savedItemsTableView.bottomAnchor.constraint(equalTo: self.backToMainButton.topAnchor,constant: -5),
            self.savedItemsTableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
        ])
        
        self.viewModel.getData()
        
        self.viewModel.functionalityWhenDataProvided = { [weak self] in
            DispatchQueue.main.async(qos: .userInteractive) {
                self?.savedItemsTableView.reloadData()
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

extension SavedItemsTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.providedDataForMaps.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = self.savedItemsTableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! PlayersTableViewHeaderView
        header.configure()
        header.setTitleLabelText(with: "Saved maps")
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.bounds.height/3.5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.savedItemsTableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! SavedItemTableViewCell
        cell.configuire(with: "Saved \(indexPath.item + 1)", image: self.viewModel.providedMapImageData[indexPath.item],with: self.view.bounds.size)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.savedItemsTableView.deselectRow(at: indexPath, animated: true)
        self.view.addSubview(self.animationViewOfLoading)
        NSLayoutConstraint.activate([
            self.animationViewOfLoading.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.animationViewOfLoading.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            self.animationViewOfLoading.widthAnchor.constraint(equalTo:self.view.widthAnchor,multiplier: 0.7),
            self.animationViewOfLoading.heightAnchor.constraint(equalTo:self.view.heightAnchor,multiplier: 0.3),
        ])
        
        UIView.animate(withDuration: 0.5) {
            self.animationViewOfLoading.alpha = 0
            self.animationViewOfLoading.alpha = 1
            self.animationViewOfLoading.play()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            let vc = ShipMapConfigurationViewController()
            vc.setViewModel(with: self.viewModel.provideDataModelsForIndexPath(indexPath: indexPath))
            self.show(vc, sender: nil)
            UIView.animate(withDuration: 0.5) {
                self.animationViewOfLoading.alpha = 1
                self.animationViewOfLoading.alpha = 0
                self.animationViewOfLoading.stop()
                self.animationViewOfLoading.removeFromSuperview()
            }
        }
    }
}
