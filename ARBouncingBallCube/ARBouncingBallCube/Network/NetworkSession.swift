//
//  NetworkSession.swift
//  ARBouncingBallCube
//
//  Created by Christopher Williams on 3/21/20.
//  Copyright © 2020 Christopher Williams. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class NetworkSession: MCSession, MCSessionDelegate {
    override init(peer myPeerID: MCPeerID, securityIdentity identity: [Any]?, encryptionPreference: MCEncryptionPreference) {
        super.init(peer: myPeerID, securityIdentity: identity, encryptionPreference: encryptionPreference)
        
        delegate = self
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        #if DEBUG
        print("session \(session) \(peerID) \(state)")
        #endif
    }

    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        #if DEBUG
        print("session \(session) \(data) \(peerID)")
        #endif
    }

    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        #if DEBUG
        print("session \(session) \(stream) \(streamName) \(peerID)")
        #endif
    }

    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        #if DEBUG
        print("session \(session) \(resourceName) \(peerID) \(progress)")
        #endif
    }

    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        #if DEBUG
        print("session \(session) \(resourceName) \(peerID) \(String(describing: localURL)) \(String(describing: error))")
        #endif
    }
}
