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
#if !targetEnvironment(simulator) && !targetEnvironment(macCatalyst)
import ARKit
#endif

class MyARView: ARView {
    var streams:[AnyCancellable] = []
    
    let anchor:AnchorEntity = AnchorEntity(world: .zero)
    
    // MARK: Constructors
    convenience init() {
        self.init(frame: .zero)
    }
    required init(frame: CGRect) {
        super.init(frame: frame)
        
        // Enable debug overlay by default
        debugOptions = .important
        
        // Disable AR on startup (on iOS device only) OR set background to black
        #if !targetEnvironment(simulator) && !targetEnvironment(macCatalyst)
        cameraMode = .nonAR
        #else
        backgroundColor = .black
        #endif
        
        // TODO: Enable networking
        scene.synchronizationService = Network.service
        
        // Add initial entities
        #if !targetEnvironment(simulator) && !targetEnvironment(macCatalyst)
        if cameraMode == .nonAR {
            anchor.children.append(Generator.myPerspectiveCamera(far: Const.Camera.far))
        }
        #else
        anchor.children.append(Generator.myPerspectiveCamera(far: Const.Camera.far))
        #endif
        anchor.children.append(OriginEntity())
        anchor.children.append(contentsOf: Generator.generateTargets())
        scene.anchors.append(anchor)
        
        // Subscribe to events
        scene.subscribe(to: SceneEvents.AnchoredStateChanged.self, anchored).store(in: &streams)
        scene.subscribe(to: SceneEvents.Update.self, updated).store(in: &streams)
        scene.subscribe(to: CollisionEvents.Began.self, collided).store(in: &streams)
        scene.subscribe(to: CollisionEvents.Updated.self, colliding).store(in: &streams)
        scene.subscribe(to: CollisionEvents.Ended.self, uncollided).store(in: &streams)
        scene.subscribe(to: SynchronizationEvents.OwnershipChanged.self, synced).store(in: &streams)
        scene.subscribe(to: SynchronizationEvents.OwnershipRequest.self, requested).store(in: &streams)
        
        // Subscribe to interactions
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped(_:))))
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped(_:)))
        doubleTap.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTap)
        let twoFingerTap = UITapGestureRecognizer(target: self, action: #selector(twoTapped(_:)))
        twoFingerTap.numberOfTouchesRequired = 2
        addGestureRecognizer(twoFingerTap)
        let threeFingerTap = UITapGestureRecognizer(target: self, action: #selector(threeTapped(_:)))
        threeFingerTap.numberOfTouchesRequired = 3
        addGestureRecognizer(threeFingerTap)
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(longPressed(_:))))
        addGestureRecognizer(UISwipeGestureRecognizer(target: self, action: #selector(swiped(_:))))
    }
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Events
    func anchored(event: SceneEvents.AnchoredStateChanged) {
        #if DEBUG
        print("anchored \(event)")
        #endif
    }
    
    func updated(event: SceneEvents.Update) {
        let origin = anchor.findEntity(named: Const.Name.origin)!
        origin.transform = cameraTransform
        origin.transform.translation += .ahead
    }
    
    func collided(event: CollisionEvents.Began) {
        #if DEBUG
        print("collided \(event)")
        #endif
        // Turn my entity red when inside trigger volume
        if event.entityA.name == Const.Name.mine
            && event.entityB.name == Const.Name.target {
            let entityA:ModelEntity = event.entityA as! ModelEntity
            entityA.model?.materials = [SimpleMaterial(color: .red,
                                                       isMetallic: false)]
        }
    }
    
    func colliding(event: CollisionEvents.Updated) {}
    
    func uncollided(event: CollisionEvents.Ended) {
        #if DEBUG
        print("uncollided \(event)")
        #endif
        // Keep my entity in trigger volume box
        if event.entityA.name == Const.Name.mine
            && event.entityB.name == Const.Name.target {
            let entityA:ModelEntity = event.entityA as! ModelEntity
            entityA.physicsMotion?.linearVelocity *= -1
        }
    }
    
    func synced(event: SynchronizationEvents.OwnershipChanged) {
        #if DEBUG
        print("synced \(event)")
        #endif
    }
    
    func requested(event: SynchronizationEvents.OwnershipRequest) {
        #if DEBUG
        print("requested \(event)")
        #endif
    }
    
    // MARK: Interactions
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        #if DEBUG
        print("tapped \(sender)")
        #endif
        // Shoot flying entity from origin box
        let dir = self.ray(through: sender.location(in: self))!.1
        anchor.children.append(Generator.myModelEntity(dir))
    }
    
    @objc func doubleTapped(_ sender: UITapGestureRecognizer) {
        #if DEBUG
        print("double tapped \(sender)")
        #endif
        anchor.children.append(contentsOf: Generator.generateTargets(num: 1))
    }
    
    @objc func twoTapped(_ sender: UITapGestureRecognizer) {
        #if DEBUG
        print("two tapped \(sender)")
        #endif
        // Switch between AR and VR views (iOS only)
        #if !targetEnvironment(simulator) && !targetEnvironment(macCatalyst)
        if cameraMode == .ar {
            cameraMode = .nonAR
            anchor.scale = SIMD3<Float>(repeating: Const.Size.vr)
            anchor.children.append(Generator.myPerspectiveCamera(far: Const.Camera.far))
        } else {
            cameraMode = .ar
            anchor.scale = SIMD3<Float>(repeating: Const.Size.ar)
            anchor.removeChild(anchor.findEntity(named: Const.Name.camera)!)
        }
        #endif
    }
    
    @objc func threeTapped(_ sender: UITapGestureRecognizer) {
        #if DEBUG
        print("three tapped \(sender)")
        #endif
        // Toggle debug overlay (iOS only)
        #if !targetEnvironment(simulator) && !targetEnvironment(macCatalyst)
        cycleDebugOverlay()
        #endif
    }
    
    @objc func longPressed(_ sender: UILongPressGestureRecognizer) {
        #if DEBUG
        print("long pressed \(sender)")
        #endif
        // Toggle debug overlay (macOS only)
        #if !targetEnvironment(simulator) && !targetEnvironment(macCatalyst)
        #else
        cycleDebugOverlay()
        #endif
    }
    
    @objc func swiped(_ sender: UISwipeGestureRecognizer) {
        #if DEBUG
        print("swiped \(sender)")
        #endif
        // Destroy all added entities
        while let entity = anchor.findEntity(named: Const.Name.mine) {
            anchor.removeChild(entity)
        }
    }
    
    // MARK: Functions
    /// Cycles debug overlays between important, on, and off
    func cycleDebugOverlay() {
        switch debugOptions {
        case .important:
            debugOptions = .all
        case .all:
            debugOptions = .none
        case .none:
            debugOptions = .important
        default:
            fatalError("Unexpected debug overlay \(debugOptions)")
        }
    }
}
