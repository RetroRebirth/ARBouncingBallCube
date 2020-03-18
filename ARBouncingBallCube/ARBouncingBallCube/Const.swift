//
//  Const.swift
//  ARBouncingBallCube
//
//  Created by Christopher Williams on 3/17/20.
//  Copyright © 2020 Christopher Williams. All rights reserved.
//

import Foundation

struct Const {
    struct Name {
        static let mine:String = "mine"
        static let origin:String = "origin"
        static let target:String = "target"
        static let rc:String = "Steel Box"
        static let camera:String = "camera"
    }
    struct Size {
        static let mine:Float = 0.1
        static let origin:Float = 0.1
        static let target:Float = 0.5
        static let ar:Float = 0.1
        static let vr:Float = 1
    }
    struct Physics {
        struct Friction {
            static let mine:Float = 0.5
        }
        struct Restitution {
            static let mine:Float = 0.5
        }
    }
    struct Camera {
        static let far:Float = 10
    }
}
