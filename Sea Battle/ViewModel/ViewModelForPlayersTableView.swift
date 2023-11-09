//
//  ViewModelForPlayersTableView.swift
//  Sea Battle
//
//  Created by Ashot Hovhannisyan on 28.09.23.
//

import Foundation
import MultipeerConnectivity

protocol Sender: AnyObject {
    var isConnectionEstablished: Bool {get set}
    func establisheConnection(_ sender: UIViewController, canEstablishe: Bool)
}

extension ViewModelForPlayersTableView: PeerIDRecieverDelegate {
   
    func getPeerId(_ sender: MultiplayerConectionAsMPCHandler,peerId: MCPeerID,discoveryInfo: [String:String]?, with type: DataType) {
        self.dataModel.handleIncomingData(data: peerId,discoveryInfo:discoveryInfo, with: type)
        self.getDataFromDataModel()
    }
    
    func setConnectionState(_ sender: MultiplayerConectionAsMPCHandler,for index: IndexPath, with state: ConnectingState) {
        self.dataModel.setConnectionState(for: index, with: state)
        if self.givenDataForConnectionStates.count >= index.row + 1 {
            self.givenDataForConnectionStates[index.row] = state
            switch state {
            case .networkMissing:
                self.functionalityWhenConnectionFailed()
            case .canceled:
                self.functionalityWhenConnectionFailed()
            default:
                break
            }
        }
    }
}

final class ViewModelForPlayersTableView {
    
    var functionalityWhenDataRecieved: () -> Void = {}
    var functionalityWhenConnectionFailed: () -> Void = {}
    
    private var dataModel: DataSourceForPlayersTableView = DataSourceForPlayersTableView()
    private(set) var multipeerConnectivityForPlayers: MultiplayerConectionAsMPCHandler! = nil
    private(set) var givenDataForPlayerNames: [String] = [String]() {
        didSet {
            functionalityWhenDataRecieved()
        }
    }
    private(set) var givenDataForConnectionStates: [ConnectingState] = [ConnectingState]() {
        didSet {
            functionalityWhenDataRecieved()
        }
    }
    private(set) var givenDataForPlayerIcons: [Data?] = [Data?]() {
        didSet {
            functionalityWhenDataRecieved()
        }
    }
    
    func setDelegateForConnectivity() {
        multipeerConnectivityForPlayers.delegate = self
    }
    
    func getDataFromDataModel() {
        self.givenDataForPlayerIcons = self.dataModel.provideDataForIcons()
        self.givenDataForPlayerNames = self.dataModel.provideDataForNames()
        self.givenDataForConnectionStates = self.dataModel.setUpWithConnectionStates()
    }
    
    func providePeerId(at index: IndexPath) -> MCPeerID {
        return self.dataModel.providePeerId(at: index)
    }
    
    func isConnected() -> Bool {
        if let _ = self.givenDataForConnectionStates.first(where: {$0 == .connected}) {
            return true
        } else {
            return false
        }
    }
    
    func setConnectivityHandler(with handler: MultiplayerConectionAsMPCHandler) {
        self.multipeerConnectivityForPlayers = handler
        self.multipeerConnectivityForPlayers.addAdvertiserToCloser()
    }

    func askToClean() {
        AdvertiserBrowserAndSessionsCloser.shared.cleanUpWithSession()
    }
    
}
