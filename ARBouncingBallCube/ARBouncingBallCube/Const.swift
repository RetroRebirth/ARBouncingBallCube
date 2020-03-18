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
        static let mine:String = "box"
        static let ground:String = "ground"
        static let origin:String = "origin"
        static let rc:String = "Steel Box"
    }
    struct Size {
        static let mine:Float = 0.1
        static let ground:Float = 1
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
}
