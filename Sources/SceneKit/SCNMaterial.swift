//
//  SCNMaterial.swift
//  SwifterSwift
//
//  Created by Max Härtwig on 06.04.19.
//  Copyright © 2019 SwifterSwift
//

#if canImport(SceneKit)
import SceneKit

// MARK: - Methods
public extension SCNMaterial {

    /// Initializes a SCNMaterial with a specific diffuse color
    ///
    /// - Parameter color: diffuse color
    convenience init(color: UIColor) {
        self.init()
        diffuse.contents = color
    }

}

#endif
