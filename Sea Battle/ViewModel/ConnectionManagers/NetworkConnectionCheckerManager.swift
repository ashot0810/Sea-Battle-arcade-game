//
//  NetworkConnectionCheckerManager.swift
//  Sea Battle
//
//  Created by Ashot Hovhannisyan on 29.09.23.
//

import Network

enum ConnectionStatus {
    case connected
    case notConnected
}

protocol NetworkConnectionCheckerManagerDelegate: AnyObject {
    func provideStatus(_sender: NetworkConnectionCheckerManager,status: ConnectionStatus)
}

final class NetworkConnectionCheckerManager {
    
    private let networkMonitor = NWPathMonitor(requiredInterfaceType: .wifi)
    private let queueForHandlingMonitoringEvents = DispatchQueue.global(qos: .userInteractive)
    weak var delegate: NetworkConnectionCheckerManagerDelegate?
    
    func provideConnectionStatus() {
        let group = DispatchGroup()
        var connectionStatus: ConnectionStatus = .notConnected
        self.networkMonitor.start(queue: queueForHandlingMonitoringEvents)
        group.enter()
        networkMonitor.pathUpdateHandler = { path in
            group.enter()
            if path.status == .satisfied {
                connectionStatus = .connected
            } else {
                connectionStatus = .notConnected
            }
            group.leave()
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.global(qos: .userInitiated)) {
            self.delegate?.provideStatus(_sender: self, status: connectionStatus)
            self.networkMonitor.cancel()
        }
    }
}
