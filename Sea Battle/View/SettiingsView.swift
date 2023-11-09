//
//  SettiingsView.swift
//  Sea Battle
//
//  Created by Ashot Hovhannisyan on 13.10.23.
//

import UIKit

@objc protocol SliderValueChangementTargetSetter {
    @objc func slidervalueChangementSelector(_ sender: UISlider)
}

@objc protocol MuteGestureTargetSetter {
    @objc func muteGestureTargetSelector(_ sender: UITapGestureRecognizer)
}

@objc protocol HaptickMuteGestureTargetSetter {
    @objc func haptickMuteGestureTargetSelector(_ sender: UITapGestureRecognizer)
}

final class SettiingsView: UIView {

    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 1
        imageView.image = UIImage(named: "BannerBackground")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 23)
        label.textAlignment = .center
        label.text = "Settings"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let volumeImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "volume.3.fill"))
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let volumeSlider: UISlider = {
        let slider = UISlider()
        slider.value = 1
        slider.maximumValue = 1
        slider.minimumValue = 0
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private let haptickImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "waveform"))
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let muteTapGestureRecognizer: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        return gesture
    }()
    
    private let haptickMuteTapGestureRecognizer: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        return gesture
    }()

    
    func configure() {
        self.clipsToBounds = true
        self.isUserInteractionEnabled = true
        self.volumeImageView.isUserInteractionEnabled = true
        self.haptickImageView.isUserInteractionEnabled = true
        self.layer.cornerRadius = 10
        
        self.addSubview(backgroundImage)
        self.addSubview(nameLabel)
        self.addSubview(volumeImageView)
        self.addSubview(volumeSlider)
        self.addSubview(haptickImageView)
        
        self.volumeImageView.addGestureRecognizer(self.muteTapGestureRecognizer)
        self.haptickImageView.addGestureRecognizer(self.haptickMuteTapGestureRecognizer)
        
        NSLayoutConstraint.activate([
            self.backgroundImage.topAnchor.constraint(equalTo: self.topAnchor),
            self.backgroundImage.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.backgroundImage.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.nameLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 5),
            self.nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.volumeImageView.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 10),
            self.volumeImageView.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor,constant: 5),
            self.volumeSlider.leftAnchor.constraint(equalTo: self.volumeImageView.rightAnchor, constant: 5),
            self.volumeSlider.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -10),
            self.volumeSlider.centerYAnchor.constraint(equalTo: self.volumeImageView.centerYAnchor),
            self.haptickImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.haptickImageView.topAnchor.constraint(equalTo: self.volumeSlider.bottomAnchor,constant: 5)
        ])
    }
    
    func setSliderTarget(with target: SliderValueChangementTargetSetter) {
        self.volumeSlider.addTarget(target, action: #selector(target.slidervalueChangementSelector), for: .valueChanged)
    }
    
    func muteGestureTarget(with target: MuteGestureTargetSetter) {
        self.muteTapGestureRecognizer.addTarget(target, action: #selector(target.muteGestureTargetSelector))
    }
    
    func haptickMuteGestureTarget(with target: HaptickMuteGestureTargetSetter) {
        self.haptickMuteTapGestureRecognizer.addTarget(target, action: #selector(target.haptickMuteGestureTargetSelector))
    }
    
    func changeVolumeImage(with image: UIImage?) {
        self.volumeImageView.image = image
    }
    
    func changeHaptickImage(with image: UIImage?) {
        self.haptickImageView.image = image
    }
    
    func changeValueOfSlider(with value: Float) {
        self.volumeSlider.value = value
    }
    
    func provideSliderValue() -> Float {
        self.volumeSlider.value
    }
}
