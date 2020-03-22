//
//  AttributedStringAppendable.swift
//  CocoaExtension
//
//  Created by 郑军铎 on 2020/3/22.
//  Copyright © 2020 zjade. All rights reserved.
//

import Foundation

protocol AttributedStringAppendable {
    init()
    mutating func append<T: AttributedStringCreater>(_ value: T)
    func appending<T: AttributedStringCreater>(_ value: T) -> Self
}
