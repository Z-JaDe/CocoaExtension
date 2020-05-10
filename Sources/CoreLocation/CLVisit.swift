//
//  CLVisit.swift
//  CocoaExtension
//
//  Created by 郑军铎 on 2020/5/10.
//  Copyright © 2020 zjade. All rights reserved.
//

import Foundation

#if canImport(CoreLocation) && (os(iOS) || targetEnvironment(macCatalyst))
import CoreLocation

// MARK: - Properties
public extension CLVisit {
    var location: CLLocation {
        return CLLocation(latitude: self.coordinate.latitude, longitude: self.coordinate.longitude)
    }
}

#endif
