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
    // MARK: Singletons
    private static var meshCovid:MeshResource?
    static func meshCovidSingleton() -> MeshResource {
        if Generator.meshCovid == nil {
            Generator.meshCovid = ((try! Entity.load(named: Const.Name.covid)).children.first!.children.first! as! ModelEntity).model?.mesh
        }
        return Generator.meshCovid!
    }
    
    // MARK: Constructors
    static func myPerspectiveCamera(far:Float=Float.infinity, fieldOfViewInDegrees:Float=60, near:Float=0.01) -> PerspectiveCamera {
        let pc = PerspectiveCamera()
        
        pc.camera.far = far
        pc.camera.fieldOfViewInDegrees = fieldOfViewInDegrees
        pc.camera.near = near
        
        pc.name = Const.Name.camera
        
        return pc
    }
    static func myTriggerVolume(_ position:SIMD3<Float>) -> TriggerVolume {
        let tv = TriggerVolume(shape: .generateBox(size: SIMD3<Float>(repeating: Const.Size.target)),
                               filter: CollisionFilter(group: .all,
                                                       mask: .all))
        
        tv.name = Const.Name.target
        tv.transform.translation = position
        
        return tv
    }
    static func myModelEntity(_ velocityDir: SIMD3<Float>) -> ModelEntity {
        let me = ModelEntity(mesh: Generator.meshCovidSingleton(),
                             materials: [SimpleMaterial(color: .green,
                                                        isMetallic: false)],
                             collisionShape: .generateSphere(radius: Const.Size.mine),
                             mass: Const.Physics.Mass.mine)
        
        me.name = Const.Name.mine
        me.transform.scale = SIMD3<Float>(repeating: Const.Size.mine)
        me.transform.translation += .ahead
        me.physicsBody?.mode = .kinematic
        me.physicsMotion = PhysicsMotionComponent(linearVelocity: velocityDir, angularVelocity: .zero)
        
        return me
    }
    
    // MARK: Functions
    static func generateTargets(num:Int=Const.Num.targets) -> [TriggerVolume] {
        var targets:[TriggerVolume] = []
        
        for _ in 0..<num {
            targets.append(Generator.myTriggerVolume(.randTargetPos))
        }
        
        return targets
    }
}
