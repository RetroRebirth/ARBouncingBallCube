//
//  Generator.swift
//  ARBouncingBallCube
//
//  Created by Christopher Williams on 3/18/20.
//  Copyright © 2020 Christopher Williams. All rights reserved.
//

import Foundation
import RealityKit

class Generator {
    static func myPerspectiveCamera(far:Float=Float.infinity, fieldOfViewInDegrees:Float=60, near:Float=0.01) -> PerspectiveCamera {
        let pc = PerspectiveCamera()
        
        pc.camera.far = far
        pc.camera.fieldOfViewInDegrees = fieldOfViewInDegrees
        pc.camera.near = near
        
        pc.name = Const.Name.camera
        pc.transform.translation = .behind
        
        return pc
    }
    static func generateTargets(num:Int=10) -> [TargetEntity] {
        var targets:[TargetEntity] = []
        
        for _ in 0..<num {
            targets.append(TargetEntity())
        }
        
        return targets
    }
}
