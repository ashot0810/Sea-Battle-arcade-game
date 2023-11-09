//
//  SavedItemCell.swift
//  Sea Battle
//
//  Created by Ashot Hovhannisyan on 14.10.23.
//

import UIKit

final class SavedItemTableViewCell: UITableViewCell {
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let savedMapImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func configuire(with text: String, image: Data, with dimensions: CGSize) {
        
        self.nameLabel.text = text
        self.savedMapImage.image = UIImage(data: image)
        
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.savedMapImage)
        self.backgroundColor = .cyan.withAlphaComponent(0.2)
        
        NSLayoutConstraint.activate([
            self.savedMapImage.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,constant: 15),
            self.savedMapImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15),
            self.savedMapImage.widthAnchor.constraint(equalToConstant: dimensions.width/4),
            self.savedMapImage.heightAnchor.constraint(equalToConstant: dimensions.height/4),
            self.nameLabel.leftAnchor.constraint(equalTo: self.savedMapImage.rightAnchor,constant: 15),
            nameLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -15),
            self.nameLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
        ])
    }
}
