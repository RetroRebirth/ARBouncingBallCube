//
//  GroundEntity.swift
//  ARBouncingBallCube
//
//  Created by Christopher Williams on 3/17/20.
//  Copyright © 2020 Christopher Williams. All rights reserved.
//

import Foundation
import RealityKit

class TargetEntity: Entity, HasPhysics, HasPhysicsBody, HasCollision, HasModel {
    required init() {
        super.init()
        
        let shape = ShapeResource.generateBox(size: .flat * Const.Size.target)
        
        name = Const.Name.target
        collision = CollisionComponent(shapes: [shape])
        physicsBody = PhysicsBodyComponent(shapes: [shape],
                                                mass: 1,
                                                material: PhysicsMaterialResource.generate(friction: Const.Physics.Friction.mine, restitution: Const.Physics.Restitution.mine),
                                                mode: .static)
        model = ModelComponent(mesh: MeshResource.generateBox(size: Const.Size.target), materials: [])
        transform.translation = .randTargetPos
    }
    convenience init(_ position:SIMD3<Float>) {
        self.init()
        
        transform.translation = position
    }
}
