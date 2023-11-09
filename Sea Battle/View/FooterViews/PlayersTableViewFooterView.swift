//
//  PlayersTableViewFooterView.swift
//  Sea Battle
//
//  Created by Ashot Hovhannisyan on 28.09.23.
//

import UIKit

final class PlayersTableViewFooterView: UITableViewHeaderFooterView {
    private let searchLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Ensure that your and players WI-FI turned on"
        label.minimumScaleFactor = 0.2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let connectionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Connection don't required"
        label.minimumScaleFactor = 0.2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .medium
        activityIndicator.color = .white
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    func configuire(with message:String) {
        
        self.backgroundView = UIImageView(image: UIImage(named: "BannerBackground"))
        self.backgroundView?.alpha = 0.3// changing background color table view's header footer view is not supported
        
        self.addSubview(activityIndicator)
        self.addSubview(searchLabel)
        self.addSubview(messageLabel)
        self.addSubview(connectionLabel)
        
        searchLabel.text = message
        self.activityIndicator.startAnimating()
        
        NSLayoutConstraint.activate([
            self.searchLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 10),
            self.searchLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 5),
            self.activityIndicator.leftAnchor.constraint(equalTo: self.searchLabel.rightAnchor,constant: 5),
            self.activityIndicator.topAnchor.constraint(equalTo: self.searchLabel.topAnchor),
            self.messageLabel.leftAnchor.constraint(equalTo: self.searchLabel.leftAnchor),
            self.messageLabel.topAnchor.constraint(equalTo:self.searchLabel.bottomAnchor, constant: 5),
            self.connectionLabel.leftAnchor.constraint(equalTo: self.searchLabel.leftAnchor),
            self.connectionLabel.topAnchor.constraint(equalTo:self.messageLabel.bottomAnchor, constant: 5)
        ])
    }
}
