//
//  Extensions.swift
//  ARBouncingBallCube
//
//  Created by Christopher Williams on 3/17/20.
//  Copyright © 2020 Christopher Williams. All rights reserved.
//

import Foundation
import RealityKit

extension SIMD3 {
    public static var up: SIMD3<Float> { get { return SIMD3<Float>(0, 1, 0) } }
    public static var down: SIMD3<Float> { get { return .up * -1 } }
    public static var ahead: SIMD3<Float> { get { return SIMD3<Float>(0, 0, -1) } }
    public static var flat: SIMD3<Float> { get { return SIMD3<Float>(1, 0, 1) } }
}

extension ARView.DebugOptions {
    #if !targetEnvironment(simulator) && !targetEnvironment(macCatalyst)
    public static var all: ARView.DebugOptions { get { return ARView.DebugOptions(arrayLiteral: .showAnchorGeometry, .showAnchorOrigins, .showFeaturePoints, .showPhysics, .showStatistics, .showWorldOrigin) } }
    #else
    public static var all: ARView.DebugOptions { get { return ARView.DebugOptions(arrayLiteral: .showPhysics, .showStatistics) } }
    #endif
    public static var important: ARView.DebugOptions { get { return ARView.DebugOptions(arrayLiteral: .showPhysics) } }
}
