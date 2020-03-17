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
        
        let shape = ShapeResource.generateSphere(radius: Const.Size.mine)
        
        self.name = Const.Name.mine
        self.collision = CollisionComponent(shapes: [shape])
        self.physicsBody = PhysicsBodyComponent(shapes: [shape],
                                                mass: 1,
                                                material: PhysicsMaterialResource.generate(friction: Const.Physics.Friction.mine, restitution: Const.Physics.Restitution.mine),
                                                mode: .dynamic)
        self.physicsMotion = PhysicsMotionComponent()
        self.model = ModelComponent(mesh: MeshResource.generateSphere(radius: Const.Size.mine), materials: [])
    }
}
