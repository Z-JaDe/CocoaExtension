//
//  ImageDrawer.swift
//  Alamofire
//
//  Created by ZJaDe on 2019/1/24.
//

import UIKit

public class ImageDrawer {
    public enum BorderAlignment {
        case inside
        case center
        case outside
    }
    public enum Size {
        case fixed(CGSize)
        case resizable
    }
    private var colors: [UIColor] = [.clear]
    private var colorLocations: [CGFloat] = Defaults.gradientLocations
    private var colorStartPoint: CGPoint = Defaults.gradientFrom
    private var colorEndPoint: CGPoint = Defaults.gradientTo

    private var borderColors: [UIColor] = [.black]
    private var borderColorLocations: [CGFloat] = Defaults.gradientLocations
    private var borderColorStartPoint: CGPoint = Defaults.gradientFrom
    private var borderColorEndPoint: CGPoint = Defaults.gradientTo
    private var borderWidth: CGFloat = 0
    private var borderAlignment: BorderAlignment = .inside

    typealias RectCorner = UInt
    private var cornerRadiusDict: [RectCorner: CGFloat] = [:]
    private func cornerRadius(_ corner: UIRectCorner) -> CGFloat {
        return self.cornerRadiusDict[corner.rawValue, default: 0]
    }
    private func setCornerRadius(_ corner: UIRectCorner, _ value: CGFloat) {
        return self.cornerRadiusDict[corner.rawValue] = value
    }

    internal var size: Size = .resizable
}
extension ImageDrawer {
    public var image: UIImage {
        switch self.size {
        case .fixed(let size):
            return self.createImage(size: size)
        case .resizable:
            self.borderAlignment = .inside

            let cornerRadius = cornerRadiusDict.values.max() ?? 0
            let capSize = ceil(max(cornerRadius, self.borderWidth))
            let imageSize = capSize * 2 + 1

            let image = self.createImageIfNeed(size: CGSize(width: imageSize, height: imageSize))
            let capInsets = UIEdgeInsets(top: capSize, left: capSize, bottom: capSize, right: capSize)
            return image.resizableImage(withCapInsets: capInsets)
        }
    }
    private func createImageIfNeed(size: CGSize, useCache: Bool = true) -> UIImage {
        if let cachedImage = type(of: self).cachedImages[self.cacheKey], useCache {
            return cachedImage
        }
        let image = self.createImage(size: size)
        if useCache {
            type(of: self).cachedImages[self.cacheKey] = image
        }
        return image
    }
    private func createImage(size: CGSize) -> UIImage {
        let (rect, imageSize) = calculateImageRect(size)
        return UIGraphicsImageRenderer(size: imageSize).image(actions: { (context) in
            let context = context.cgContext
            let path = getPath(rect, imageSize)
            drawFill(context, path, imageSize)
            drawStroke(context, path, imageSize)
        })
    }
    func drawFill(_ context: CGContext, _ path: UIBezierPath, _ imageSize: CGSize) {
        context.saveGState()
        if self.colors.count > 1 {
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let colors = self.colors.map(\.cgColor) as CFArray
            if let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: self.colorLocations) {
                let startPoint = CGPoint(
                    x: self.colorStartPoint.x * imageSize.width,
                    y: self.colorStartPoint.y * imageSize.height
                )
                let endPoint = CGPoint(
                    x: self.colorEndPoint.x * imageSize.width,
                    y: self.colorEndPoint.y * imageSize.height
                )
                context.addPath(path.cgPath)
                context.clip()
                context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
            }
        } else {
            self.colors.first?.setFill()
            path.fill()
        }
        context.restoreGState()
    }
    func drawStroke(_ context: CGContext, _ path: UIBezierPath, _ imageSize: CGSize) {
        context.saveGState()
        if self.borderColors.count > 1 {
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let colors = self.borderColors.map(\.cgColor) as CFArray
            if let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: self.borderColorLocations) {
                let startPoint = CGPoint(
                    x: self.borderColorStartPoint.x * imageSize.width,
                    y: self.borderColorStartPoint.y * imageSize.height
                )
                let endPoint = CGPoint(
                    x: self.borderColorEndPoint.x * imageSize.width,
                    y: self.borderColorEndPoint.y * imageSize.height
                )
                context.addPath(path.cgPath)
                context.setLineWidth(self.borderWidth)
                context.replacePathWithStrokedPath()
                context.clip()
                context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
            }
        } else {
            self.borderColors.first?.setStroke()
            path.lineWidth = self.borderWidth
            path.stroke()
        }
        context.restoreGState()
    }
    // swiftlint:disable function_body_length
    func getPath(_ rect: CGRect, _ imageSize: CGSize) -> UIBezierPath {
        guard self.cornerRadiusDict.values.max() ?? 0 > 0 else {
            return UIBezierPath(rect: rect)
        }
        let topLeft = self.cornerRadius(.topLeft)
        let topRight = self.cornerRadius(.topRight)
        let bottomRight = self.cornerRadius(.bottomRight)
        let bottomLeft = self.cornerRadius(.bottomLeft)
        if self.cornerRadiusDict.values.allSatisfy({$0 == topLeft}) && topLeft > 0 {
            return UIBezierPath(roundedRect: rect, cornerRadius: topLeft)
        }
        let mutablePath: UIBezierPath = UIBezierPath()
        let startAngle = CGFloat.pi

        let topLeftCenter = CGPoint(
            x: topLeft + self.borderWidth / 2,
            y: topLeft + self.borderWidth / 2
        )
        let topRightCenter = CGPoint(
            x: imageSize.width - topRight - self.borderWidth / 2,
            y: topRight + self.borderWidth / 2
        )
        let bottomRightCenter = CGPoint(
            x: imageSize.width - bottomRight - self.borderWidth / 2,
            y: imageSize.height - bottomRight - self.borderWidth / 2
        )
        let bottomLeftCenter = CGPoint(
            x: bottomLeft + self.borderWidth / 2,
            y: imageSize.height - bottomLeft - self.borderWidth / 2
        )

        if topLeft > 0 {
            mutablePath.addArc(withCenter: topLeftCenter, radius: topLeft, startAngle: startAngle, endAngle: 1.5 * startAngle, clockwise: true)
        } else {
            mutablePath.move(to: topLeftCenter)
        }
        if topRight > 0 {
            mutablePath.addArc(withCenter: topRightCenter, radius: topRight, startAngle: 1.5 * startAngle, endAngle: 2 * startAngle, clockwise: true)
        } else {
            mutablePath.addLine(to: topRightCenter)
        }
        if bottomRight > 0 {
            mutablePath.addArc(withCenter: bottomRightCenter, radius: bottomRight, startAngle: 2 * startAngle, endAngle: 2.5 * startAngle, clockwise: true)
        } else {
            mutablePath.addLine(to: bottomRightCenter)
        }
        if bottomLeft > 0 {
            mutablePath.addArc(withCenter: bottomLeftCenter, radius: bottomLeft, startAngle: 2.5 * startAngle, endAngle: 3 * startAngle, clockwise: true)
        } else {
            mutablePath.addLine(to: bottomLeftCenter)
        }

        if topLeft > 0 {
            mutablePath.addLine(to: CGPoint(x: self.borderWidth / 2, y: topLeftCenter.y))
        } else {
            mutablePath.addLine(to: topLeftCenter)
        }
        return mutablePath
    }
    func calculateImageRect(_ imageSize: CGSize) -> (CGRect, CGSize) {
        var imageSize = imageSize
        var rect = CGRect(origin: CGPoint.zero, size: imageSize)
        switch self.borderAlignment {
        case .inside:
            rect.origin.x += self.borderWidth / 2
            rect.origin.y += self.borderWidth / 2
            rect.size.width -= self.borderWidth
            rect.size.height -= self.borderWidth
        case .center:
            rect.origin.x += self.borderWidth / 2
            rect.origin.y += self.borderWidth / 2
            imageSize.width += self.borderWidth
            imageSize.height += self.borderWidth
        case .outside:
            rect.origin.x += self.borderWidth / 2
            rect.origin.y += self.borderWidth / 2
            rect.size.width += self.borderWidth
            rect.size.height += self.borderWidth
            imageSize.width += self.borderWidth * 2
            imageSize.height += self.borderWidth * 2
        }
        return (rect, imageSize)
    }
}
public extension ImageDrawer {
    func color(_ color: UIColor?) -> Self {
        self.colors = [color ?? UIColor.clear]
        return self
    }
    func color(
        gradient: [UIColor],
        locations: [CGFloat] = Defaults.gradientLocations,
        from startPoint: CGPoint = Defaults.gradientFrom,
        to endPoint: CGPoint = Defaults.gradientTo
        ) -> Self {
        self.colors = gradient
        self.colorLocations = locations
        self.colorStartPoint = startPoint
        self.colorEndPoint = endPoint
        return self
    }
}
public extension ImageDrawer {
    func corner(radius: CGFloat) -> Self {
        return self.corner(topLeft: radius, topRight: radius, bottomLeft: radius, bottomRight: radius)
    }
    func corner(topLeft: CGFloat) -> Self {
        setCornerRadius(.topLeft, topLeft)
        return self
    }
    func corner(topRight: CGFloat) -> Self {
        setCornerRadius(.topRight, topRight)
        return self
    }
    func corner(bottomLeft: CGFloat) -> Self {
        setCornerRadius(.bottomLeft, bottomLeft)
        return self
    }
    func corner(bottomRight: CGFloat) -> Self {
        setCornerRadius(.bottomRight, bottomRight)
        return self
    }
    func corner(topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat) -> Self {
        return self
            .corner(topLeft: topLeft)
            .corner(topRight: topRight)
            .corner(bottomLeft: bottomLeft)
            .corner(bottomRight: bottomRight)
    }
}
public extension ImageDrawer {
    struct Defaults {
        public static let gradientLocations: [CGFloat] = [0, 1]
        public static let gradientFrom: CGPoint = .zero
        public static let gradientTo: CGPoint = CGPoint(x: 0, y: 1)
    }
    func border(color: UIColor) -> Self {
        self.borderColors = [color]
        return self
    }
    func border(
        gradient: [UIColor],
        locations: [CGFloat] = Defaults.gradientLocations,
        from startPoint: CGPoint = Defaults.gradientFrom,
        to endPoint: CGPoint = Defaults.gradientTo
        ) -> Self {
        self.borderColors = gradient
        self.borderColorLocations = locations
        self.borderColorStartPoint = startPoint
        self.borderColorEndPoint = endPoint
        return self
    }

    func border(width: CGFloat) -> Self {
        self.borderWidth = width
        return self
    }

    func border(alignment: BorderAlignment) -> Self {
        self.borderAlignment = alignment
        return self
    }
}
extension ImageDrawer {
    private static var cachedImages = [String: UIImage]()
    private var cacheKey: String {
        var attributes = [String: String]()
        attributes["colors"] = String(self.colors.description.hashValue)
        attributes["colorLocations"] = String(self.colorLocations.description.hashValue)
        attributes["colorStartPoint"] = String(String(describing: self.colorStartPoint).hashValue)
        attributes["colorEndPoint"] = String(String(describing: self.colorEndPoint).hashValue)

        attributes["borderColors"] = String(self.borderColors.description.hashValue)
        attributes["borderColorLocations"] = String(self.borderColorLocations.description.hashValue)
        attributes["borderColorStartPoint"] = String(String(describing: self.borderColorStartPoint).hashValue)
        attributes["borderColorEndPoint"] = String(String(describing: self.borderColorEndPoint).hashValue)
        attributes["borderWidth"] = String(self.borderWidth.hashValue)
        attributes["borderAlignment"] = String(self.borderAlignment.hashValue)

        attributes["cornerRadiusDict"] = String(cornerRadiusDict.hashValue)

        switch self.size {
        case .fixed(let size):
            attributes["size"] = "Fixed(\(size.width), \(size.height))"
        case .resizable:
            attributes["size"] = "Resizable"
        }

        var serializedAttributes = [String]()
        for key in attributes.keys.sorted() {
            if let value = attributes[key] {
                serializedAttributes.append("\(key): \(value)")
            }
        }
        let cacheKey = serializedAttributes.joined(separator: "|")
        return cacheKey
    }
}
