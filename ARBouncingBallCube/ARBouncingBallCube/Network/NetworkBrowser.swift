//
//  NetworkBrowser.swift
//  ARBouncingBallCube
//
//  Created by Christopher Williams on 3/21/20.
//  Copyright © 2020 Christopher Williams. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class NetworkBrowser: MCNearbyServiceBrowser, MCNearbyServiceBrowserDelegate {
    override init(peer myPeerID: MCPeerID, serviceType: String) {
        super.init(peer: myPeerID, serviceType: serviceType)
        
        delegate = self
        startBrowsingForPeers()
    }
    
    func browser(_ browser: MCNearbyServiceBrowser,
                 foundPeer peerID: MCPeerID,
                 withDiscoveryInfo info: [String : String]?) {
        #if DEBUG
        print("browser \(browser) \(peerID) \(String(describing: info))")
        #endif
    }

    func browser(_ browser: MCNearbyServiceBrowser,
                 lostPeer peerID: MCPeerID) {
        #if DEBUG
        print("browser \(browser) \(peerID)")
        #endif
    }
}
