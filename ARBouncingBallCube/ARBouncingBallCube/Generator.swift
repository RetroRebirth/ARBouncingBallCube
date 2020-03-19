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
    static var covidModel:ModelComponent?
    
    static func myPerspectiveCamera(far:Float=Float.infinity, fieldOfViewInDegrees:Float=60, near:Float=0.01) -> PerspectiveCamera {
        let pc = PerspectiveCamera()
        
        pc.camera.far = far
        pc.camera.fieldOfViewInDegrees = fieldOfViewInDegrees
        pc.camera.near = near
        
        pc.name = Const.Name.camera
        
        return pc
    }
    static func generateTargets(num:Int=10) -> [TargetEntity] {
        var targets:[TargetEntity] = []
        
        for _ in 0..<num {
            targets.append(TargetEntity())
        }
        
        return targets
    }
    static func modelCovid() -> ModelComponent {
        if Generator.covidModel == nil {
            Generator.covidModel = ((try! Entity.load(named: "covid.usdz")).children.first!.children.first! as! ModelEntity).model
        }
        return Generator.covidModel!
    }
}
