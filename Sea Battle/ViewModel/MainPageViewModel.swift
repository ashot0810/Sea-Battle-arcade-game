//
//  MainPageViewModel.swift
//  Sea Battle
//
//  Created by Ashot Hovhannisyan on 14.10.23.
//

import Foundation
import UIKit.UIImage

final class MainPageViewModel {
    
    private(set) var volumeSliderValue: Float?

    func configuireHaptick(with state: Bool) {
        AudioEffectsManager.shared.changeEnablationOfHaptick(with: state)
    }
    
    func configuirePlayersVolume(with volume: Float) {
        AudioEffectsManager.shared.changeVolume(with: volume)
    }
    
    func setVolumeSliderValue(with value: Float) {
        self.volumeSliderValue = value
    }
    
    func askToSetPlayerImage(with image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 0.01) else {return}
        DataSavingManager.savePlayerImage(with: data)
    }
}
