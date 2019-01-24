//
//  ImageDrawer.swift
//  CocoaExtension
//
//  Created by 郑军铎 on 2019/1/24.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation


public extension UIImage {
    public class func create(width: CGFloat, height: CGFloat) -> ImageDrawer {
        return self.create(CGSize(width: width, height: height))
    }
    public class func create(_ size: CGSize) -> ImageDrawer {
        let drawer = ImageDrawer()
        drawer.size = .fixed(size)
        return drawer
    }
    public class func createResizable() -> ImageDrawer {
        let drawer = ImageDrawer()
        drawer.size = .resizable
        return drawer
    }
}
