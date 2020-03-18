//
//  GroundEntity.swift
//  ARBouncingBallCube
//
//  Created by Christopher Williams on 3/17/20.
//  Copyright © 2020 Christopher Williams. All rights reserved.
//

import Foundation
import RealityKit

class GroundEntity: Entity, HasPhysics, HasPhysicsBody, HasCollision, HasModel {
    required init() {
        super.init()
        
        let shape = ShapeResource.generateBox(size: .flat * Const.Size.ground)
        
        name = Const.Name.ground
        collision = CollisionComponent(shapes: [shape])
        physicsBody = PhysicsBodyComponent(shapes: [shape],
                                                mass: 1,
                                                material: PhysicsMaterialResource.generate(friction: Const.Physics.Friction.mine, restitution: Const.Physics.Restitution.mine),
                                                mode: .static)
        model = ModelComponent(mesh: MeshResource.generateBox(size: .flat * Const.Size.ground), materials: [])
        transform.translation = .down
    }
}
