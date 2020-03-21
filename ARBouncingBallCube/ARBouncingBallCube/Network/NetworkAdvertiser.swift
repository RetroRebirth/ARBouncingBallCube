//
//  NetworkAdvertiser.swift
//  ARBouncingBallCube
//
//  Created by Christopher Williams on 3/21/20.
//  Copyright © 2020 Christopher Williams. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class NetworkAdvertiser: MCNearbyServiceAdvertiser, MCNearbyServiceAdvertiserDelegate {
    override init(peer myPeerID: MCPeerID, discoveryInfo info: [String : String]?, serviceType: String) {
        super.init(peer: myPeerID, discoveryInfo: info, serviceType: serviceType)
        
        delegate = self
        startAdvertisingPeer()
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser,
                    didReceiveInvitationFromPeer peerID: MCPeerID,
                    withContext context: Data?,
                    invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        #if DEBUG
        print("advertiser \(advertiser) \(peerID) \(String(describing: context)) \(String(describing: invitationHandler))")
        #endif
    }
}
