//
//  CLLocationArray.swift
//  CocoaExtension
//
//  Created by 郑军铎 on 2020/5/10.
//  Copyright © 2020 zjade. All rights reserved.
//

import Foundation

#if canImport(CoreLocation)
import CoreLocation

// MARK: - Methods
public extension Array where Element: CLLocation {

    @available(tvOS 10.0, macOS 10.12, watchOS 3.0, *)
    func distance(unitLength unit: UnitLength) -> Measurement<UnitLength> {
        guard count > 1 else {
          return Measurement(value: 0.0, unit: unit)
        }
        var distance = 0.0
        for idx in 0..<count-1 {
            distance += self[idx].distance(from: self[idx + 1])
        }
        return Measurement(value: distance, unit: UnitLength.meters).converted(to: unit)
    }
}

#endif
