//
//  SCNSphere.swift
//  SwifterSwift
//
//  Created by Max Härtwig on 06.04.19.
//  Copyright © 2019 SwifterSwift
//

#if canImport(SceneKit)
import SceneKit

// MARK: - Methods
public extension SCNSphere {

    /// Creates a sphere geometry with the specified diameter.
    ///
    /// - Parameter diameter: The diameter of the sphere in its local coordinate space.
    convenience init(diameter: CGFloat) {
        self.init(radius: diameter / 2)
    }

    /// Creates a sphere geometry with the specified radius and material.
    ///
    /// - Parameters:
    ///   - radius: The radius of the sphere in its local coordinate space.
    ///   - material: The material of the geometry.
    convenience init(radius: CGFloat, material: SCNMaterial) {
        self.init(radius: radius)
        materials = [material]
    }

    /// Creates a sphere geometry with the specified radius and material color.
    ///
    /// - Parameters:
    ///   - radius: The radius of the sphere in its local coordinate space.
    ///   - color: The color of the geometry's material.
    convenience init(radius: CGFloat, color: UIColor) {
        self.init(radius: radius, material: SCNMaterial(color: color))
    }

    /// Creates a sphere geometry with the specified diameter and material.
    ///
    /// - Parameters:
    ///   - diameter: The diameter of the sphere in its local coordinate space.
    ///   - material: The material of the geometry.
    convenience init(diameter: CGFloat, material: SCNMaterial) {
        self.init(radius: diameter / 2)
        materials = [material]
    }

    /// Creates a sphere geometry with the specified diameter and material color.
    ///
    /// - Parameters:
    ///   - diameter: The diameter of the sphere in its local coordinate space.
    ///   - color: The color of the geometry's material.
    convenience init(diameter: CGFloat, color: UIColor) {
        self.init(diameter: diameter, material: SCNMaterial(color: color))
    }

}

#endif
