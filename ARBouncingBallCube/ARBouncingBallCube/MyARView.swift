//
//  BallARView.swift
//  ARBouncingBallCube
//
//  Created by Christopher Williams on 3/17/20.
//  Copyright © 2020 Christopher Williams. All rights reserved.
//

import Foundation
import RealityKit
import Combine
import CoreGraphics
import UIKit
#if !targetEnvironment(macCatalyst)
import ARKit
#endif

class MyARView: ARView {
    /// Class consts
    let anchor:AnchorEntity = AnchorEntity(world: .zero)
    
    /// Class vars
    var streams:[AnyCancellable] = []
    
    /// Constructors
    convenience init() {
        self.init(frame: .zero)
    }
    required init(frame: CGRect) {
        super.init(frame: frame)
        
        // Enable debug overlay
        debugOptions = .important
        
        // Disable AR on startup (on iOS device only) OR set background to black
        #if !targetEnvironment(simulator) && !targetEnvironment(macCatalyst)
        cameraMode = .nonAR
        #else
        backgroundColor = .black
        #endif
        
        // Add initial entities to anchor, then anchor to scene
        anchor.children.append(OriginEntity())
        anchor.children.append(GroundEntity())
        scene.anchors.append(anchor)
        
        // Subscribe to events
        scene.subscribe(to: SceneEvents.AnchoredStateChanged.self, anchorStateChanged).store(in: &streams)
        scene.subscribe(to: SceneEvents.Update.self, updated).store(in: &streams)
        scene.subscribe(to: CollisionEvents.Began.self, collided).store(in: &streams)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped(_:))))
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(longPressed(_:))))
        addGestureRecognizer(UISwipeGestureRecognizer(target: self, action: #selector(swiped(_:))))
    }
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Functions
    func anchorStateChanged(event: SceneEvents.AnchoredStateChanged) {
        #if DEBUG
        print("anchored \(event.isAnchored) \(event.anchor)")
        #endif
    }
    
    func updated(event: SceneEvents.Update) {}
    
    func collided(event: CollisionEvents.Began) {
        #if DEBUG
        print("collided \(event.entityA) and \(event.entityB)")
        #endif
    }
    
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        #if DEBUG
        print("tapped")
        #endif
        // Shoot flying entity from origin box
        let dir = self.ray(through: sender.location(in: self))!.1
        anchor.children.append(MyEntity(dir))
    }
    
    @objc func longPressed(_ sender: UILongPressGestureRecognizer) {
        #if DEBUG
        print("long pressed")
        #endif
        // Destroy all added entities
        while let entity = anchor.findEntity(named: Const.Name.mine) {
            anchor.removeChild(entity)
        }
    }
    
    @objc func swiped(_ sender: UISwipeGestureRecognizer) {
        #if DEBUG
        print("swiped")
        #endif
        // Switch between AR and VR
        #if !targetEnvironment(simulator) && !targetEnvironment(macCatalyst)
        if cameraMode == .ar {
            cameraMode = .nonAR
            anchor.scale = SIMD3<Float>(repeating: Const.Size.vr)
        } else {
            cameraMode = .ar
            anchor.scale = SIMD3<Float>(repeating: Const.Size.ar)
        }
        #endif
    }
}
