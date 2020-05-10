//
//  String+Hex.swift
//  Alamofire
//
//  Created by Apple on 2019/5/28.
//

import Foundation

public extension String {
    init?(hex: String) {
        self.init(bytes: [UInt8](hex: hex), encoding: .utf8)
    }
    var bytes: [UInt8] {
        data(using: .utf8, allowLossyConversion: true)?.bytes ?? Array(utf8)
    }
    var hexString: String {
        bytes.hexString
    }
}
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
public extension Array where Element == UInt8 {
    init(hex: String) {
        self.init()
        self.reserveCapacity(hex.unicodeScalars.lazy.underestimatedCount)
        var buffer: UInt8?
        var skip = hex.hasPrefix("0x") ? 2 : 0
        for char in hex.unicodeScalars.lazy {
            guard skip == 0 else {
                skip -= 1
                continue
            }
            guard char.value >= 48 && char.value <= 102 else {
                removeAll()
                return
            }
            let v: UInt8
            let c: UInt8 = UInt8(char.value)
            switch c {
            case let c where c <= 57:
                v = c - 48
            case let c where c >= 65 && c <= 70:
                v = c - 55
            case let c where c >= 97:
                v = c - 87
            default:
                removeAll()
                return
            }
            if let b = buffer {
                append(b << 4 | v)
                buffer = nil
            } else {
                buffer = v
            }
        }
        if let b = buffer {
            append(b)
        }
    }
    var hexString: String {
        lazy.reduce(into: "") {
            var s = String.init($1, radix: 16)
            if s.count == 1 {
                s = "0" + s
            }
            $0 += s
        }
    }
}
