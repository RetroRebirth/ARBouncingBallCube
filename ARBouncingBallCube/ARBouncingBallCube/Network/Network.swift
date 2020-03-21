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
    static var peerID:MCPeerID!
    static var advertiser:NetworkAdvertiser!
    static var browser:NetworkBrowser!
    static var session:NetworkSession!
    static var service:MultipeerConnectivityService!
}
