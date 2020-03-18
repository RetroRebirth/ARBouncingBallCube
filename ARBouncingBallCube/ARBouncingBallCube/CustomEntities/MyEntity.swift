//
//  BoxEntity.swift
//  ARBouncingBallCube
//
//  Created by Christopher Williams on 3/17/20.
//  Copyright © 2020 Christopher Williams. All rights reserved.
//

import Foundation
import RealityKit

class MyEntity: Entity, HasPhysics, HasPhysicsBody, HasCollision, HasModel {
    required init() {
        super.init()
        
        let shape = ShapeResource.generateBox(size: SIMD3<Float>(repeating: Const.Size.mine))
        
        name = Const.Name.mine
        collision = CollisionComponent(shapes: [shape])
        physicsBody = PhysicsBodyComponent(shapes: [shape],
                                           mass: 1,
                                           material: PhysicsMaterialResource.generate(friction: Const.Physics.Friction.mine, restitution: Const.Physics.Restitution.mine),
                                           mode: .kinematic)
        physicsMotion = PhysicsMotionComponent()
        model = ModelComponent(mesh: MeshResource.generateBox(size: SIMD3<Float>(repeating: Const.Size.mine)), materials: [])
    }
    convenience init(_ velocityDir: SIMD3<Float>) {
        self.init()
        physicsMotion = PhysicsMotionComponent(linearVelocity: velocityDir, angularVelocity: .zero)
    }
}
