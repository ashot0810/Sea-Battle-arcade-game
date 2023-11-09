//
//  DataSourceForPlayersTableView.swift
//  Sea Battle
//
//  Created by Ashot Hovhannisyan on 28.09.23.
//

import Foundation
import MultipeerConnectivity
import UIKit.UIImage

extension String {
    func convertingStringToImageData() -> Data? {
        guard let image = UIImage(named: self) else {return nil}
        return image.jpegData(compressionQuality: 0.01)
    }
}

enum DataType {
    case lost
    case get
}

enum ConnectingState {
    case notNonnected
    case connecting
    case connected
    case networkMissing
    case canceled
}

struct DataSourceForPlayersTableView {
    
    private var dataSource: [MCPeerID] = [MCPeerID]()
    
    private var dataSourceOfGenders: [String] = [String]()
    
    private var connectingState: [ConnectingState] = [ConnectingState]()
    
    func provideDataForNames() -> [String] {
        return self.dataSource.map({$0.displayName})
    }
    
    mutating func setUpWithConnectionStates() -> [ConnectingState] {
        self.connectingState = [ConnectingState].init(repeating: .notNonnected, count: self.dataSource.count)
        return self.connectingState
    }
    
    func provideDataForIcons() -> [Data?] {
        return self.dataSourceOfGenders.map({$0.convertingStringToImageData()})
    }
    
    mutating func handleIncomingData(data: MCPeerID,discoveryInfo: [String:String]?, with type: DataType) {
        switch type {
        case .lost:
            for i in 0..<self.dataSource.count {
                if self.dataSource[i] == data {
                    self.dataSourceOfGenders.remove(at: i)
                    self.connectingState.remove(at: i)
                }
            }
            self.dataSource.removeAll(where: {$0 == data})
        case .get:
            if self.dataSource.contains(data) {
                self.dataSource.removeAll(where: {$0 == data})
                self.dataSource.append(data)
            } else {
                self.dataSource.append(data)
            }
            guard let discoveryInfo = discoveryInfo else {return}
            guard let info = discoveryInfo["gender"] else {return}
            if info == "boy" {
                self.dataSourceOfGenders.append("defaultBoyPlayerIcon")
            } else {
                self.dataSourceOfGenders.append("defaultGirlPlayerIcon")
            }
        }
    }
    
    mutating func setConnectionState(for index: IndexPath, with state: ConnectingState) {
        if self.connectingState.count >= index.row + 1 {
            self.connectingState[index.row] = state
        }
    }
    
    func providePeerId(at index: IndexPath) -> MCPeerID {
        return self.dataSource[index.row]
    }
}
