//
//  AudioEffectsManager.swift
//  Sea Battle
//
//  Created by Ashot Hovhannisyan on 12.10.23.
//

import AVFoundation
import Foundation
import UIKit

fileprivate var gameSoundPlayer: AVAudioPlayer?
fileprivate var clickSoundPlayer: AVAudioPlayer?
fileprivate var explosionSoundPlayer: AVAudioPlayer?
fileprivate var seaDropSoundPlayer: AVAudioPlayer?
fileprivate var inviteSoundPlayer: AVAudioPlayer?
fileprivate var winningSoundPlayer: AVAudioPlayer?
fileprivate var losinSoundPlayer: AVAudioPlayer?
fileprivate var airplaneSoundPlayer: AVAudioPlayer?

final class AudioEffectsManager {
    
    static var shared: AudioEffectsManager {
        return AudioEffectsManager()
    }
    
    private(set) var gameSoundNsDataAsset: NSDataAsset = NSDataAsset(name: "gameSound")!
    private(set) var airplaneSoundNsDataAsset: NSDataAsset = NSDataAsset(name: "airplaneSound")!
    private(set) var clickSoundNsDataAsset: NSDataAsset = NSDataAsset(name: "clickSound")!
    private(set) var explosionSoundNsDataAsset: NSDataAsset = NSDataAsset(name: "explosionSound")!
    private(set) var inviteSoundNsDataAsset: NSDataAsset = NSDataAsset(name: "inviteSound")!
    private(set) var losingSoundNsDataAsset: NSDataAsset =  NSDataAsset(name: "losingSound")!
    private(set) var winningSoundNsDataAsset: NSDataAsset =  NSDataAsset(name: "winningSound")!
    private(set) var seaDropSoundNsDataAsset: NSDataAsset = NSDataAsset(name: "seaDropSound")!
    
    private(set) static var volume: Float = 1 {
        didSet {
            DataSavingManager.savePlayersVolume(with: volume)
            gameSoundPlayer?.volume = volume
            clickSoundPlayer?.volume = volume
            explosionSoundPlayer?.volume = volume
            seaDropSoundPlayer?.volume = volume
            inviteSoundPlayer?.volume = volume
            winningSoundPlayer?.volume = volume
            losinSoundPlayer?.volume = volume
            airplaneSoundPlayer?.volume = volume
        }
    }
    private(set) static var isHaptickEnable: Bool = true {
        didSet {
            DataSavingManager.saveHaptickState(with: isHaptickEnable)
        }
    }
    
    private init() {}
 
    func changeVolume(with volume: Float) {
        Self.volume = volume
    }
    
    func changeEnablationOfHaptick(with state: Bool) {
        Self.isHaptickEnable = state
    }
    
    func provideHaptickState() -> Bool {
        Self.isHaptickEnable
    }
    
}

internal func playGameSound() {
    try? AVAudioSession.sharedInstance().setMode(.default)
    try? AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
    gameSoundPlayer = try? AVAudioPlayer(data: AudioEffectsManager.shared.gameSoundNsDataAsset.data, fileTypeHint: "mp3")
    gameSoundPlayer?.volume = AudioEffectsManager.volume
    DispatchQueue.global().async(qos: .userInteractive) {
        gameSoundPlayer?.prepareToPlay()
        gameSoundPlayer?.numberOfLoops = .max
        gameSoundPlayer?.play()
    }
}

internal func playClickSound() {
    try? AVAudioSession.sharedInstance().setMode(.default)
    try? AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
    clickSoundPlayer = try? AVAudioPlayer(data: AudioEffectsManager.shared.clickSoundNsDataAsset.data, fileTypeHint: "mp3")
    clickSoundPlayer?.volume = AudioEffectsManager.volume
    DispatchQueue.global().async(qos: .userInteractive) {
        clickSoundPlayer?.prepareToPlay()
        clickSoundPlayer?.play()
    }
}

internal func playExplosionSound() {
    try? AVAudioSession.sharedInstance().setMode(.default)
    try? AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
    explosionSoundPlayer = try? AVAudioPlayer(data: AudioEffectsManager.shared.explosionSoundNsDataAsset.data, fileTypeHint: "mp3")
    explosionSoundPlayer?.volume = AudioEffectsManager.volume
    DispatchQueue.global().async(qos: .userInteractive) {
        explosionSoundPlayer?.prepareToPlay()
        explosionSoundPlayer?.play()
    }
}

internal func playSeaDropSound() {
    try? AVAudioSession.sharedInstance().setMode(.default)
    try? AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
    seaDropSoundPlayer = try? AVAudioPlayer(data: AudioEffectsManager.shared.seaDropSoundNsDataAsset.data, fileTypeHint: "mp3")
    seaDropSoundPlayer?.volume = AudioEffectsManager.volume
    DispatchQueue.global().async(qos: .userInteractive) {
        explosionSoundPlayer?.prepareToPlay()
        explosionSoundPlayer?.play()
    }
}

internal func playInviteSound() {
    try? AVAudioSession.sharedInstance().setMode(.default)
    try? AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
    inviteSoundPlayer = try? AVAudioPlayer(data: AudioEffectsManager.shared.inviteSoundNsDataAsset.data, fileTypeHint: "mp3")
    inviteSoundPlayer?.volume = AudioEffectsManager.volume
    DispatchQueue.global().async(qos: .userInteractive) {
        inviteSoundPlayer?.prepareToPlay()
        inviteSoundPlayer?.play()
    }
}

internal func playWinningSound() {
    try? AVAudioSession.sharedInstance().setMode(.default)
    try? AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
    winningSoundPlayer = try? AVAudioPlayer(data: AudioEffectsManager.shared.winningSoundNsDataAsset.data, fileTypeHint: "mp3")
    winningSoundPlayer?.volume = AudioEffectsManager.volume
    DispatchQueue.global().async(qos: .userInteractive) {
        winningSoundPlayer?.prepareToPlay()
        winningSoundPlayer?.play()
    }
}

internal func playLosingSound() {
    try? AVAudioSession.sharedInstance().setMode(.default)
    try? AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
    losinSoundPlayer = try? AVAudioPlayer(data: AudioEffectsManager.shared.losingSoundNsDataAsset.data, fileTypeHint: "mp3")
    losinSoundPlayer?.volume = AudioEffectsManager.volume
    DispatchQueue.global().async(qos: .userInteractive) {
        losinSoundPlayer?.prepareToPlay()
        losinSoundPlayer?.play()
    }
}

internal func playAirplaneSound() {
    try? AVAudioSession.sharedInstance().setMode(.default)
    try? AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
    airplaneSoundPlayer = try? AVAudioPlayer(data: AudioEffectsManager.shared.airplaneSoundNsDataAsset.data, fileTypeHint: "mp3")
    airplaneSoundPlayer?.volume = AudioEffectsManager.volume
    DispatchQueue.global().async(qos: .userInteractive) {
        airplaneSoundPlayer?.prepareToPlay()
        airplaneSoundPlayer?.play()
    }
}
