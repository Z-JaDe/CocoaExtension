//
//  ImageDrawer.swift
//  CocoaExtension
//
//  Created by ZJaDe on 2019/1/24.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

public extension UIImage {
    static func create(width: CGFloat, height: CGFloat) -> ImageDrawer {
        return self.create(CGSize(width: width, height: height))
    }
    static func create(_ size: CGSize) -> ImageDrawer {
        let drawer = ImageDrawer()
        drawer.size = .fixed(size)
        return drawer
    }
    static func createResizable() -> ImageDrawer {
        let drawer = ImageDrawer()
        drawer.size = .resizable
        return drawer
    }
    static func create(color: UIColor?) -> UIImage {
        return createResizable().color(color).image
    }
    static func create(color: UIColor?, _ size: CGSize) -> UIImage {
        return create(size).color(color).image
    }
}
// MARK: - gradient
public extension UIImage {
    enum GradientDirection {
        case topToBottom
        case bottomToTop
        case leftToRight
        case rightToLeft
    }
    private static func calculatePoints(_ direction: GradientDirection) -> (CGPoint, CGPoint) {
        let startPoint: CGPoint
        let endPoint: CGPoint
        switch direction {
        case .topToBottom:
            startPoint = CGPoint(x: 0.5, y: 0)
            endPoint = CGPoint(x: 0.5, y: 1)
        case .bottomToTop:
            startPoint = CGPoint(x: 0.5, y: 1)
            endPoint = CGPoint(x: 0.5, y: 0)
        case .leftToRight:
            startPoint = CGPoint(x: 0, y: 0.5)
            endPoint = CGPoint(x: 1, y: 0.5)
        case .rightToLeft:
            startPoint = CGPoint(x: 1, y: 0.5)
            endPoint = CGPoint(x: 0, y: 0.5)
        }
        return (startPoint, endPoint)
    }
    // MARK: -
    static func horizontalGradient(_ size: CGSize? = nil, colors: UIColor...) -> UIImage {
        return gradient(.leftToRight, size, colors: colors)
    }
    static func verticalGradient(_ size: CGSize? = nil, colors: UIColor...) -> UIImage {
        return gradient(.topToBottom, size, colors: colors)
    }
    static func gradient(_ direction: GradientDirection, _ size: CGSize? = nil, colors: UIColor...) -> UIImage {
        return gradient(direction, size, colors: colors)
    }
    static func gradient(_ direction: GradientDirection, _ size: CGSize? = nil, colors: [UIColor]) -> UIImage {
        let drawer: ImageDrawer
        if let size = size {
            drawer = create(size)
        } else {
            drawer = createResizable()
        }
        let (startPoint, endPoint) = calculatePoints(direction)
        let locations = colors.enumerated().map({CGFloat($0.offset) / CGFloat(colors.count - 1)})
        return drawer.color(gradient: colors, locations: locations, from: startPoint, to: endPoint).image
    }
}
