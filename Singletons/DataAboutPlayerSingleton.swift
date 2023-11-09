//
//  DataAboutPlayerSingleton.swift
//  Sea Battle
//
//  Created by Ashot Hovhannisyan on 01.10.23.
//

import Foundation
import UIKit.UIImage
import SimpleKeychain

extension String {
    func split(by length: Int) -> [String] {
        var startIndex = self.startIndex
        var results = [Substring]()

        while startIndex < self.endIndex {
            let endIndex = self.index(startIndex, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            results.append(self[startIndex..<endIndex])
            startIndex = endIndex
        }

        return results.map { String($0) }
    }
}

final class DataAboutPlayerSingleton {
    
    static var shared: DataAboutPlayerSingleton {
        return DataAboutPlayerSingleton()
    }
    
    private static var playerName: String = DataSavingManager.providePlayerName()
    private(set) static var playerDefaultIcon: UIImage? = {
        if DataSavingManager.providePlayerGender() == "boy" {
            return UIImage(named: "defaultBoyPlayerIcon")
        } else {
            return UIImage(named: "defaultGirlPlayerIcon")
        }
    }()
    
    private static var playerIcon: UIImage? = {
        if let data = DataSavingManager.provideImage() {
            return UIImage(data: data)
        } else {
            if DataSavingManager.providePlayerGender() == "boy" {
                return UIImage(named: "defaultBoyPlayerIcon")
            } else {
                return UIImage(named: "defaultGirlPlayerIcon")
            }
        }
    }()
    
    private static var iconDataDescription: Data? {
        return playerIcon?.jpegData(compressionQuality: 1)
    }
    private static var playerGender: String! = DataSavingManager.providePlayerGender()
    private static var playerInfo: SeaBattlePlayer! = nil
    private(set) static var isLeaveGame: Bool = false
    private static var isConnected: Bool = false
    private static var opponentName: String = ""
    private static var opponentIcon: Data = Data()
    
    private init() {}
    
    func setOpponentName(with name: String) {
        Self.opponentName = name
    }
    
    func setOpponentIcon(with icon: Data) {
        Self.opponentIcon = icon
    }
    
    func setLeaved() {
        Self.isLeaveGame = true
        guard Self.isConnected else {return}
        let date = Date()
        DataSavingManager(info: date.timeIntervalSince1970, key: "leavingDate").saveInstance()
        DataSavingManager(info: Self.opponentName, key: "opponentName").saveInstance()
        DataSavingManager.setOneResult(with: GameWinnerLoserResult(playerName: DataAboutPlayerSingleton.shared.providePlayerName(), playerIconDescription: DataAboutPlayerSingleton.shared.provideIconDescription(), opponentName: DataAboutPlayerSingleton.opponentName, opponentIconDescription: DataAboutPlayerSingleton.opponentIcon, playerScores: 0, opponentScores: 500, isWinner: false))
    }
    
    func restoreLeaved() {
        Self.isLeaveGame = false
    }
    
    func setPlayerIcon(with image: UIImage) {
        Self.playerIcon = image
    }
    
    func setConnectingStatus(with status: Bool) {
        Self.isConnected = status
    }
    
    func setPlayer(with mapInfo: [String]) {
        Self.playerInfo = SeaBattlePlayer(playerName: Self.playerName, playerIconDescription: Self.iconDataDescription!, playergender: Self.playerGender, mapData: mapInfo)
    }
    
    func providePlayer() -> SeaBattlePlayer {
        return Self.playerInfo
    }
    
    func providePlayerName() -> String {
        return Self.playerName
    }
    
    func providePlayerIcon() -> UIImage? {
        guard let data = DataSavingManager.provideImage() else {
            return Self.playerDefaultIcon
        }
        return UIImage(data: data)
    }
    
    func providePlayerDefaultIcon() -> UIImage? {
        return Self.playerDefaultIcon
    }
    
    func provideIconDescription() -> Data {
        guard let data = Self.iconDataDescription else {return Data.init()}
        return data
    }
    
    func providePlayerGender() -> String {
        return Self.playerGender
    }
    
    func reload() {
        Self.playerName = DataSavingManager.providePlayerName()
        Self.playerGender = DataSavingManager.providePlayerGender()
        Self.playerDefaultIcon = {
            if DataSavingManager.providePlayerGender() == "boy" {
                return UIImage(named: "defaultBoyPlayerIcon")
            } else {
                return UIImage(named: "defaultGirlPlayerIcon")
            }
        }()
        
        Self.playerIcon = {
            if let data = DataSavingManager.provideImage() {
                return UIImage(data: data)
            } else {
                if DataSavingManager.providePlayerGender() == "boy" {
                    return UIImage(named: "defaultBoyPlayerIcon")
                } else {
                    return UIImage(named: "defaultGirlPlayerIcon")
                }
            }
        }()
    }
    
}

struct SeaBattlePlayer: Codable {
    private(set) var playerName:String
    private(set) var playerIconDescription: Data
    private(set) var playergender: String
    private(set) var mapData:[String]
    
    init(playerName: String, playerIconDescription: Data, playergender: String, mapData: [String]) {
        self.playerName = playerName
        self.playerIconDescription = playerIconDescription
        self.playergender = playergender
        self.mapData = mapData
    }
}

struct PlayerContextualData: Codable {
    private(set) var playerName:String
    private(set) var playerIconDescription: Data

    init(playerName: String, playerIconDescription: Data) {
        self.playerName = playerName
        self.playerIconDescription = playerIconDescription
    }
}

struct DataSavingManager {
    private var info: Any
    private var key: String
    
    init(info: Any, key: String) {
        self.info = info
        self.key = key
    }
    
    static func savePlayerName(with name: String) {
        UserDefaults(suiteName: "group.io.SeaBattleid.myapp")?.setValue(name, forKey: "name")
    }
    
    static func saveStateIsSetted() {
        UserDefaults(suiteName: "group.io.SeaBattleid.myapp")?.set(true, forKey: "setted")
    }
    
    static func providePlayerName() -> String {
        return UserDefaults(suiteName: "group.io.SeaBattleid.myapp")?.string(forKey: "name") ?? "Player"
    }
    
    static func savePlayerGender(with gender: String) {
        UserDefaults(suiteName: "group.io.SeaBattleid.myapp")?.setValue(gender, forKey: "gender")
    }
    
    static func providePlayerGender() -> String {
        return UserDefaults(suiteName: "group.io.SeaBattleid.myapp")?.string(forKey: "gender") ?? "boy"
    }
    
    static func saveHaptickState(with state: Bool) {
        UserDefaults.standard.setValue(state, forKey: "haptickState")
    }
    
    static func savePlayersVolume(with volume: Float) {
        UserDefaults.standard.setValue(volume, forKey: "playersVolume")
    }
    
    static func provideHaptickState() -> Bool {
        guard let state = UserDefaults.standard.value(forKey: "haptickState") as? Bool else {
            return true
        }
        return state
    }
    
    static func providePlayersVolume() -> Float {
        guard let volume = UserDefaults.standard.value(forKey: "playersVolume") as? Float else {
            return 1
        }
        return volume
    }
    
    static func savePlayerImage(with data: Data) {
        try? SimpleKeychain().set(data, forKey: "playerImage")
    }
    
    static func provideImage() -> Data? {
        guard let data = try? SimpleKeychain().data(forKey: "playerImage") else {return nil}
        return data
    }
    
    static func saveMap(with info: [String]) {
        if let existedData = UserDefaults.standard.value(forKey: "savedMaps") as? Data {
            guard var decodedData = try? JSONDecoder().decode([[String]].self, from: existedData) else {return}
            decodedData.append(info)
            guard let json = try? JSONEncoder().encode(decodedData) else {return}
            UserDefaults.standard.setValue(json, forKey: "savedMaps")
        } else {
            guard let json = try? JSONEncoder().encode([info]) else {return}
            UserDefaults.standard.setValue(json, forKey: "savedMaps")
        }
    }
    
    static func saveShipsLeftRotated(with info: [String]) {
        if let existedData = UserDefaults.standard.value(forKey: "savedShipsLeft") as? Data {
            guard var decodedData = try? JSONDecoder().decode([[String]].self, from: existedData) else {return}
            decodedData.append(info)
            guard let json = try? JSONEncoder().encode(decodedData) else {return}
            UserDefaults.standard.setValue(json, forKey: "savedShipsLeft")
        } else {
            guard let json = try? JSONEncoder().encode([info]) else {return}
            UserDefaults.standard.setValue(json, forKey: "savedShipsLeft")
        }
    }
    
    static func saveShipsRightRotated(with info: [String]) {
        if let existedData = UserDefaults.standard.value(forKey: "savedShipsRight") as? Data {
            guard var decodedData = try? JSONDecoder().decode([[String]].self, from: existedData) else {return}
            decodedData.append(info)
            guard let json = try? JSONEncoder().encode(decodedData) else {return}
            UserDefaults.standard.setValue(json, forKey: "savedShipsRight")
        } else {
            guard let json = try? JSONEncoder().encode([info]) else {return}
            UserDefaults.standard.setValue(json, forKey: "savedShipsRight")
        }
    }
    
    static func saveWaterMarksData(with data: [Int:Int]) {
        if let existedData = UserDefaults.standard.value(forKey: "waterMarksData") as? Data {
            guard var decodedData = try? JSONDecoder().decode([[Int:Int]].self, from: existedData) else {return}
            decodedData.append(data)
            guard let json = try? JSONEncoder().encode(decodedData) else {return}
            UserDefaults.standard.setValue(json, forKey: "waterMarksData")
        } else {
            guard let json = try? JSONEncoder().encode([data]) else {return}
            UserDefaults.standard.setValue(json, forKey: "waterMarksData")
        }
    }
    
    static func saveMapsImage(with image:Data) {
        guard let existedData = try? SimpleKeychain().data(forKey: "mapsImage") else {
            guard let firstData = try? JSONEncoder().encode([image]) else {return}
            try? SimpleKeychain().set(firstData,forKey: "mapsImage")
            return
        }
        guard var decodedData = try? JSONDecoder().decode([Data].self, from: existedData) else {return}
        decodedData.append(image)
        guard let finalData = try? JSONEncoder().encode(decodedData) else {return}
        try? SimpleKeychain().set(finalData,forKey: "mapsImage")
    }
    
    static func saveShipsCount(with count: Int) {
        if var existedData = UserDefaults.standard.value(forKey: "shipsCount") as? [Int] {
            existedData.append(count)
            UserDefaults.standard.setValue(existedData, forKey: "shipsCount")
        } else {
            UserDefaults.standard.setValue([count], forKey: "shipsCount")
        }
    }
    
    static func loadMapsImage() -> [Data] {
        guard let data =  try? SimpleKeychain().data(forKey: "mapsImage") else {return [Data]()}
        guard let decodedData = try? JSONDecoder().decode([Data].self, from: data) else {return [Data]()}
        return decodedData
    }
    
    static func loadSavedMaps() -> [[String]] {
        if let data = UserDefaults.standard.value(forKey: "savedMaps") as? Data {
            guard let decodedData = try? JSONDecoder().decode([[String]].self, from: data) else {
                return [[String]]()
            }
            return decodedData
        } else {
            return [[String]]()
        }
    }
    
    static func loadSavedShipsLeftRotated() -> [[String]] {
        if let data = UserDefaults.standard.value(forKey: "savedShipsLeft") as? Data {
            guard let decodedData = try? JSONDecoder().decode([[String]].self, from: data) else {
                return [[String]]()
            }
            return decodedData
        } else {
            return [[String]]()
        }
    }
    
    static func loadSavedShipsRightRotated() -> [[String]] {
        if let data = UserDefaults.standard.value(forKey: "savedShipsRight") as? Data {
            guard let decodedData = try? JSONDecoder().decode([[String]].self, from: data) else {
                return [[String]]()
            }
            return decodedData
        } else {
            return [[String]]()
        }
    }
    
    static func loadWaterMarksData() -> [[Int:Int]] {
        if let data = UserDefaults.standard.value(forKey: "waterMarksData") as? Data {
            guard let decodedData = try? JSONDecoder().decode([[Int:Int]].self, from: data) else {
                return [[Int:Int]]()
            }
            return decodedData
        } else {
            return [[Int:Int]]()
        }
    }
    
    static func loadShipsCountData() -> [Int] {
        if let data = UserDefaults.standard.value(forKey: "shipsCount") as? [Int] {
            return data
        } else {
            return [Int]()
        }
    }
    
    func saveInstance() {
        UserDefaults.standard.setValue(self.info, forKey: self.key)
    }
    
    static func cleanUpUserDefaultsAndKeyChain() {
        UserDefaults.standard.removeObject(forKey: "leavingDate")
        UserDefaults.standard.removeObject(forKey: "opponentName")
        try? SimpleKeychain().deleteItem(forKey: "oneResult")
    }
    
    static func savingGameResult(with result: GameWinnerLoserResult) {
        guard let existedData = try? SimpleKeychain().data(forKey: "gameResult") else {
            let savingData: [GameWinnerLoserResult] = [result]
            guard let json = try? JSONEncoder().encode(savingData) else {return}
            try? SimpleKeychain().set(json,forKey: "gameResult")
            return
        }
        guard var decodedData = try? JSONDecoder().decode([GameWinnerLoserResult].self, from: existedData) else {return}
        decodedData.append(result)
        guard let newData = try? JSONEncoder().encode(decodedData) else {return}
        try? SimpleKeychain().set(newData,forKey: "gameResult")
    }
    
    static func setOneResult(with result: GameWinnerLoserResult) {
        guard let newData = try? JSONEncoder().encode(result) else {return}
        try? SimpleKeychain().set(newData,forKey: "oneResult")
    }
}

struct GameWinnerLoserResult: Codable {
    private(set) var playerName:String
    private(set) var playerIconDescription: Data
    private(set) var opponentName:String
    private(set) var opponentIconDescription: Data
    private(set) var playerScores: Int
    private(set) var opponentScore: Int
    private(set) var isWinner: Bool

    init(playerName: String, playerIconDescription: Data, opponentName: String, opponentIconDescription: Data, playerScores: Int, opponentScores: Int, isWinner: Bool) {
        self.playerName = playerName
        self.playerIconDescription = playerIconDescription
        self.opponentName = opponentName
        self.opponentIconDescription = opponentIconDescription
        self.playerScores = playerScores
        self.opponentScore = opponentScores
        self.isWinner = isWinner
    }
    
}


