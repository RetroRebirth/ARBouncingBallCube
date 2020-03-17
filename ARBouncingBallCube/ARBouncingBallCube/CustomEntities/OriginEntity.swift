//
//  OriginEntity.swift
//  ARBouncingBallCube
//
//  Created by Christopher Williams on 3/17/20.
//  Copyright © 2020 Christopher Williams. All rights reserved.
//

import Foundation
import RealityKit

class OriginEntity: Entity, HasModel {
    required init() {
        super.init()
        
        self.name = Const.Name.origin
        self.model = ModelComponent(mesh: MeshResource.generateBox(size: SIMD3<Float>(repeating: Const.Size.mine)), materials: [])
    }
}
