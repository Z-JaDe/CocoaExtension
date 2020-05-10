//
//  Data.swift
//  CocoaExtension
//
//  Created by 郑军铎 on 2020/5/10.
//  Copyright © 2020 zjade. All rights reserved.
//

import Foundation

public extension Data {
    init(hex: String) {
        self.init([UInt8](hex: hex))
    }
    var bytes: [UInt8] {
        Array(self)
    }
    var hexString: String {
        bytes.hexString
    }
}
