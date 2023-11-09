//
//  AdvertiserSessionsCloser.swift
//  Sea Battle
//
//  Created by Ashot Hovhannisyan on 01.10.23.
//

import MultipeerConnectivity

final class AdvertiserBrowserAndSessionsCloser {
    
    static var shared: AdvertiserBrowserAndSessionsCloser {
        return AdvertiserBrowserAndSessionsCloser()
    }
    
    private static var advertisersSet: Set<MCNearbyServiceAdvertiser> = Set<MCNearbyServiceAdvertiser>()
    private static var browsersSet: Set<MCNearbyServiceBrowser> = Set<MCNearbyServiceBrowser>()
    private static var sessionsSet: Set<MCSession> = Set<MCSession>()

    private init(){}
    
    func addConnectiveManagers(advertiser: MCNearbyServiceAdvertiser,browser: MCNearbyServiceBrowser,session: MCSession) {
        Self.advertisersSet.insert(advertiser)
        Self.browsersSet.insert(browser)
        Self.sessionsSet.insert(session)
    }
    
    func cleanUpWithSession() {
        for i in Self.advertisersSet {
            i.delegate = nil
            i.stopAdvertisingPeer()
        }
        for i in Self.browsersSet {
            i.delegate = nil
            i.stopBrowsingForPeers()
        }
        for i in Self.sessionsSet {
            i.delegate = nil
            i.disconnect()
        }
    }
}

final class SessionDisconector {

    private static var session: MCSession! = nil
    private static var sender: UIViewController?
    
    static var shared: SessionDisconector {
        SessionDisconector()
    }
    
    private init() {}
    
    func disconnectorOfSession() {
        guard Self.session != nil && Self.sender != nil else {return}
        Self.session.disconnect()
    }
    
    func setDisconnectorSession(with session: MCSession) {
        Self.session = session
    }
    
    func setSender(with sender: UIViewController) {
        Self.sender = sender
    }
    
    func resetSender() {
        Self.sender = nil
    }
}
