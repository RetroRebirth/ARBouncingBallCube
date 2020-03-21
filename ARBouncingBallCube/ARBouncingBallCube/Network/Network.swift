//
//  Network.swift
//  ARBouncingBallCube
//
//  Created by Christopher Williams on 3/21/20.
//  Copyright © 2020 Christopher Williams. All rights reserved.
//

import Foundation
import RealityKit
import MultipeerConnectivity

class Network {
    static let peerID:MCPeerID = MCPeerID(displayName: Const.Name.display)
    static let advertiser:NetworkAdvertiser = NetworkAdvertiser(peer: Network.peerID, discoveryInfo: nil, serviceType: Const.Name.display)
    static let browser:NetworkBrowser = NetworkBrowser(peer: Network.peerID, serviceType: Const.Name.display)
    static let session:NetworkSession = NetworkSession(peer: Network.peerID, securityIdentity: nil, encryptionPreference: .required)
    static let service:MultipeerConnectivityService = try! MultipeerConnectivityService(session: Network.session)
}
