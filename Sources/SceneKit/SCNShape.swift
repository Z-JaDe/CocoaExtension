//
//  SCNShape.swift
//  SwifterSwift
//
//  Created by Max Härtwig on 06.04.19.
//  Copyright © 2019 SwifterSwift
//

#if canImport(SceneKit)
import SceneKit

#if canImport(UIKit)
import UIKit
#endif

// MARK: - Methods
public extension SCNShape {

    #if canImport(UIKit)

    /// Creates a shape geometry with the specified path, extrusion depth, and material.
    ///
    /// - Parameters:
    ///   - path: The two-dimensional path forming the basis of the shape.
    ///   - extrusionDepth: The thickness of the extruded shape along the z-axis.
    ///   - material: The material of the geometry.
    convenience init(path: UIBezierPath, extrusionDepth: CGFloat, material: SCNMaterial) {
        self.init(path: path, extrusionDepth: extrusionDepth)
        materials = [material]
    }

    /// Creates a shape geometry with the specified path, extrusion depth, and material.
    ///
    /// - Parameters:
    ///   - path: The two-dimensional path forming the basis of the shape.
    ///   - extrusionDepth: The thickness of the extruded shape along the z-axis.
    ///   - color: The color of the geometry's material.
    convenience init(path: UIBezierPath, extrusionDepth: CGFloat, color: UIColor) {
        self.init(path: path, extrusionDepth: extrusionDepth)
        materials = [SCNMaterial(color: color)]
    }

    #endif

}

#endif
